//
//  SearchResultView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 23/08/2023.
//

import SwiftUI

struct SearchResultView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var searchViewModel: SearchViewModel
    @State var selectedTab: SearchTabs = .artists
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
                            .padding(.leading, item == .artists ? 10 : 0)
                        }
                    }
                }
                .padding(.bottom, 10)
                switch selectedTab {
                case .artists:
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(searchEntity.artists) { item in
                            HStack(spacing: 10) {
                                AsyncImageView(url: item.url, width: 60, height: 60, corenerRadius: 50)
                                
                                Text(item.title)
                                    .font(.headline)
                                    .lineLimit(1)
                                
                                Symbols.checkMark
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.blue)
                                
                                Spacer()
                                
                                Button(action: {}, label: {
                                    Symbols.arrowRight
                                        .font(.title2)
                                })
                            }
                            .frame(height: 60, alignment: .center)
                        }
                    }
                    .padding(.horizontal, 15)
                case .songs:
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(searchEntity.tracks) {item in
                            TrackView(title: item.title, subtitle: item.subtitle, imageUrl: item.url)
                        }
                    }
                    .padding(.horizontal, 15)
                case .playlists:
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridColumn) {
                            ForEach(searchEntity.playlists) { item in
                                PlaylistAlbumView(title: item.title, imageUrl: item.url) {
                                    router.push(.detail(id: item.id, type: "\(FeedType.playlist)"))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                case .albums:
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridColumn) {
                            ForEach(searchEntity.albums) { item in
                                PlaylistAlbumView(title: item.title, imageUrl: item.url) {
                                    router.push(.detail(id: item.id, type: "\(FeedType.album)"))
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
