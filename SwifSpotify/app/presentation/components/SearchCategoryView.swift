//
//  SearchCategoriesView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 23/08/2023.
//

import SwiftUI

struct SearchCategoryView: View {
    @EnvironmentObject private var searchViewModel: SearchViewModel
    @EnvironmentObject private var router: Router
    let gridColumn = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        let state = searchViewModel.searchState
        
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
}
