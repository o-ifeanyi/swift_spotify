//
//  SearchResultView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 23/08/2023.
//

import SwiftUI

enum SearchTabs: String, CaseIterable {
    case songs = "Songs"
    case playlists = "Playlists"
    case albums = "Albums"
}

struct SearchResultView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var playerViewModel: PlayerViewModel
    @EnvironmentObject private var searchViewModel: SearchViewModel
    @State var selectedTab: SearchTabs = .songs
    let gridColumn = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        let state = searchViewModel.searchState
        
        if state.searching {
            ScrollView(.vertical) {
                ProgressView()
            }
        } else if !state.searchingErr.isEmpty {
            ScrollView(.vertical) {
                Text("An error occured")
            }
        } else {
            let searchEntity = state.searchEnity!
            
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(SearchTabs.allCases, id: \.self) { item in
                            let selected = item == selectedTab
                            
                            PillView(
                                text: item.rawValue,
                                selected: selected,
                                action: {
                                    selectedTab = item
                                    print(selectedTab)
                                }
                            )
                            .padding(.leading, item == .songs ? 10 : 0)
                        }
                    }
                }
                .padding(.bottom, 10)
                switch selectedTab {
                case .songs:
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(searchEntity.tracks) {item in
                            TrackView(title: item.title, subtitle: item.subtitle, imageUrl: item.url) {
                                playerViewModel.setQueue(val: searchEntity.tracks)
                                playerViewModel.play(item)
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                case .playlists:
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridColumn) {
                            ForEach(searchEntity.playlists) { item in
                                PlaylistAlbumView(title: item.header, imageUrl: item.url) {
                                    router.push(.detail(id: item.id, type: "\(item.type)"))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                case .albums:
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridColumn) {
                            ForEach(searchEntity.albums) { item in
                                PlaylistAlbumView(title: item.header, imageUrl: item.url) {
                                    router.push(.detail(id: item.id, type: "\(item.type)"))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
            }
        }
    }
}
