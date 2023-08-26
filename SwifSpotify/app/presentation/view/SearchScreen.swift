//
//  SearchView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 04/06/2023.
//

import SwiftUI

struct SearchScreen: View {
    @EnvironmentObject private var searchViewModel: SearchViewModel
    @EnvironmentObject private var router: Router
    @State private var search: String = ""
    
    let debouncer = Debouncer(delay: TimeInterval(1))
    
    var body: some View {
        let state = searchViewModel.searchState
        
        VStack {
            if search.isEmpty {
                SearchCategoryView()
            } else {
                SearchResultView()
            }
            
        }
        .safeAreaInset(edge: .top) {
            GroupBox {
                HStack {
                    Symbols.search
                    TextField("What do you want to listen to?", text: $search)
                }
            }
            .padding()
            .background(.bar)
        }
        .task {
            if state.categories.isEmpty {
                await searchViewModel.fetchCategories()
            }
        }
        .overlay(alignment: .bottom) {
            if !state.gettingCategoriesErr.isEmpty {
                SnackbarView(text: state.gettingCategoriesErr)
            }
        }
        .onChange(of: search, perform: { query in
            if !query.isEmpty {
                debouncer.call {
                    Task {
                        await searchViewModel.search(query: query)
                    }
                }
            }
        })
    }
}
