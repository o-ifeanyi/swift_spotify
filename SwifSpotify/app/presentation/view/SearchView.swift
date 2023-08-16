//
//  SearchView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 04/06/2023.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var searchViewModel: SearchViewModel
    @EnvironmentObject private var router: Router
    @State private var search: String = ""
    
    let gridColumn = Array(repeating: GridItem(.flexible()), count: 2)
    var body: some View {
        let state = searchViewModel.searchState
        
        ScrollView(.vertical, showsIndicators: false) {
            if state.gettingCategories {
                ProgressView()
            } else {
                VStack(alignment: .leading) {
                    
                    Text("Browse all")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    LazyVGrid(columns: gridColumn) {
                        ForEach(state.categories) { item in
                            Button(action: {
                                router.push(.categoryPlaylist(id: item.id, title: item.name))
                            }, label: {
                                ZStack {
                                    Color.random()
                                }
                                .overlay(alignment: .bottomTrailing) {
                                    AsyncImageView(url: item.icons.first?.url, width: 80, height: 80, corenerRadius: 8)
                                        .rotationEffect(.degrees(30))
                                        .offset(x: 10, y: 10)
                                }
                                .overlay(alignment: .topLeading) {
                                    Text(item.name)
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(10)
                                }
                                .cornerRadius(4)
                                .frame(height: 100)
                                .padding(4)
                            })
                            .task {
                                if searchViewModel.isLastItem(id: item.id) && !state.gettingMoreCategories {
                                        await searchViewModel.fetchCategories()
                                }
                            }
                        }
                    }
                    
                    if state.hasMoreCategories {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal, 15)
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
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(Router())
            .environmentObject(SearchViewModel())
    }
}
