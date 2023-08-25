//
//  SearchViewModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 28/06/2023.
//

import Foundation

struct SearchState {
    var gettingCategories: Bool = true
    var gettingMoreCategories: Bool = true
    var gettingCategoriesErr: String = ""

    var categories: [CategoryIconModel] = []
    var hasMoreCategories: Bool = true
    var categoriesPage: Int = 0
    
    var gettingCategoryPlaylist: Bool = true
    var gettingCategoryPlaylistErr: String = ""

    var categoryPlaylist: [HomeFeedData] = []
    
    var searching: Bool = false
    var searchingErr: String = ""
}

final class SearchViewModel: ObservableObject {
    @Service private var searchRepository: SearchRepository
    @Service private var detailRepository: DetailRepository
    
    @Published private(set) var searchState = SearchState()
    
    @MainActor
    func fetchCategories(reset: Bool = false) async {
        if reset { resetCategoriesState() }
        
        guard searchState.hasMoreCategories else { return }
            
        searchState.gettingCategoriesErr = ""
        if searchState.categoriesPage == 0 {
            searchState.gettingCategories = true
        } else {
            searchState.gettingMoreCategories = true
        }
        
        defer {
            searchState.gettingCategories = false
            searchState.gettingMoreCategories = false
        }
        
        let res = await searchRepository.getCategories(offset: searchState.categoriesPage, limit: 20)
        switch res {
        case .success(let data):
            searchState.categories += data.items ?? []
            searchState.hasMoreCategories = data.next != nil
            searchState.categoriesPage += 20
        case .failure(let failure):
            searchState.gettingCategoriesErr = failure.localizedDescription
        }
    }
    
    @MainActor
    func fetchCategoryPlaylists(id: String) async {
        searchState.gettingCategoryPlaylistErr = ""
        searchState.gettingCategoryPlaylist = true
        
        defer { searchState.gettingCategoryPlaylist = false }
        
        let res = await searchRepository.getCategoryPlaylist(id: id, offset: 0, limit: 20)
        switch res {
        case .success(let data):
            searchState.categoryPlaylist = data.toCategoryPlaylist()
           
        case .failure(let failure):
            searchState.gettingCategoryPlaylistErr = failure.localizedDescription
        }
    }
    
    @MainActor
    func search(query: String) async {
        searchState.searchingErr = ""
        searchState.searching = true
        
        defer { searchState.searching = false }
        
        let res = await searchRepository.search(query: query, offset: 0, limit: 20)
        switch res {
        case .success(_):
            searchState.searchingErr = ""
           
        case .failure(let failure):
            searchState.searchingErr = failure.localizedDescription
        }
    }
    
    func resetCategoriesState() {
        searchState.categories = []
        searchState.hasMoreCategories = true
        searchState.categoriesPage = 0
    }
    
    func isLastItem(id: String) -> Bool {
        return searchState.categories.last?.id == id
    }
}
