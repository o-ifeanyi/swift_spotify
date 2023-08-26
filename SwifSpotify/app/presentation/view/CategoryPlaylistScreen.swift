//
//  CategoryPlaylistView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 30/06/2023.
//

import SwiftUI

struct CategoryPlaylistScreen: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var searchViewModel: SearchViewModel
    @State var id: String
    @State var title: String
    
    let gridColumn = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        let state = searchViewModel.searchState
        
        VStack {
            if state.gettingCategoryPlaylist {
                EmptyView()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: gridColumn) {
                        ForEach(state.categoryPlaylist) { item in
                            PlaylistAlbumView(title: item.header, imageUrl: item.url) {
                                router.push(.detail(id: item.id, type: "\(item.type)"))
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.large)
        .task {
            await searchViewModel.fetchCategoryPlaylists(id: id)
        }
    }
}
