//
//  DetailView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 14/06/2023.
//

import SwiftUI

struct DetailScreen: View {
    @EnvironmentObject private var detailViewModel: DetailViewModel
    @State private var searchText = ""
    
    let id: String
    let type: String
    
    var body: some View {
        let detailState = detailViewModel.detailState
        let isPlaylist = type == "playlist"
        let isAlbum = type == "album"
        
        ScrollView(.vertical, showsIndicators: false) {
            if  (isPlaylist && detailState.gettingPlaylist) || (isAlbum && detailState.gettingAlbum) {
                EmptyView()
            } else if !detailState.gettingAlbumErr.isEmpty || !detailState.gettingPlaylistErr.isEmpty {
                HStack {
                    Spacer()
                    Text("An error occurred")
                    Spacer()
                }
            } else {
                let detailEntity = detailState.detailEntity!
                
                AsyncImageView(url: detailEntity.url, width: UIScreen.screenWidth * 0.7, height: UIScreen.screenHeight * 0.3)
                
                VStack(alignment: .leading) {
                    Text(detailEntity.description)
                        .font(.subheadline)
                    HStack {
                        if isAlbum {
                            AsyncImageView(url: detailEntity.url, width: 34, height: 34)
                                .cornerRadius(30)
                            
                            Text("\(detailEntity.name)")
                                .fontWeight(.semibold)
                        } else {
                            Image("logo-green")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 34, height: 34)
                            
                            Text("Spotify")
                                .fontWeight(.semibold)
                        }
                        
                    }
                    if isAlbum {
                        Text("Album • 2020")
                    } else {
                        Text("7,270,659 saves • 3h 59m")
                    }
                    
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {}, label: {
                            Symbols.plusCircle
                                .font(.title2)
                        })
                        Button(action: {}, label: {
                            Symbols.downCircle
                                .font(.title2)
                        })
                        Button(action: {}, label: {
                            Symbols.ellipsis
                                .font(.title2)
                        })
                        Spacer()
                        Button(action: {}, label: {
                            Symbols.shuffle
                                .font(.title2)
                        })
                        Button(action: {}, label: {
                            Symbols.play
                                .font(.title2)
                        })
                        .padding()
                        .background(Theme.accent.cornerRadius(50))
                    }
                    
                    ForEach(detailEntity.tracks) { track in
                        TrackView(title: track.title, subtitle: track.artist, imageUrl: track.url)
                    }
                }
                .padding()
            }
    
        }
        .searchable(text: $searchText, prompt: "Find in playlist")
        .task {
            if isPlaylist {
                await detailViewModel.fetchPlaylist(id: id)
            } else if isAlbum {
                await detailViewModel.fetchAlbum(id: id)
            }
        }
        .overlay(alignment: .bottom) {
            if !detailState.gettingAlbumErr.isEmpty {
                SnackbarView(text: detailState.gettingAlbumErr)
            }
            if !detailState.gettingPlaylistErr.isEmpty {
                SnackbarView(text: detailState.gettingPlaylistErr)
            }
        }
    }
}
