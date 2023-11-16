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

    var categories: [CategoryIconModel] = []
    var hasMoreCategories: Bool = true
    var categoriesPage: Int = 0
    var gettingCategoryPlaylist: Bool = true
    var categoryPlaylist: [HomeFeedData] = []
    var searching: Bool = true
    var searchEnity: SearchEntity? = nil
}

final class SearchViewModel: ObservableObject {
    @Service private var searchRepository: SearchRepository
    @Service private var detailRepository: DetailRepository
    
    @Published private(set) var searchState = SearchState()
    private var snackBarService: SnackBarService
    
    init(_ snackBarService: SnackBarService = .shared) {
        self.snackBarService = snackBarService
    }
    
    @MainActor
    func fetchCategories(reset: Bool = false) async {
        if reset { resetCategoriesState() }
        
        guard searchState.hasMoreCategories else { return }
            
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
            snackBarService.displayError(failure)
        }
    }
    
    @MainActor
    func fetchCategoryPlaylists(id: String) async {
        searchState.gettingCategoryPlaylist = true
        
        defer { searchState.gettingCategoryPlaylist = false }
        
        let res = await searchRepository.getCategoryPlaylist(id: id, offset: 0, limit: 20)
        switch res {
        case .success(let data):
            searchState.categoryPlaylist = data.toCategoryPlaylist()
           
        case .failure(let failure):
            snackBarService.displayError(failure)
        }
    }
    
    @MainActor
    func search(query: String) async {
        searchState.searching = true
        
        defer { searchState.searching = false }
        
        let res = await searchRepository.search(query: query, offset: 0, limit: 20)
        switch res {
        case .success(let data):
            searchState.searchEnity = data.toSearchEntity()
           
        case .failure(let failure):
            snackBarService.displayError(failure)
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
