//
//  PlayerView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 01/09/2023.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject private var playerViewModel: PlayerViewModel
    @EnvironmentObject private var router: Router
    let action: () -> Void
    
    var body: some View {
        let state = playerViewModel.playerState
        
        if state.nowPlaying == nil {
            EmptyView()
        } else {
            Button(action: action, label: {
                HStack(spacing: 10) {
                    AsyncImageView(url: state.nowPlaying!.url, width: 50, height: 50, corenerRadius: 8)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(state.nowPlaying!.title)
                            .font(.subheadline)
                            .lineLimit(1)
                            .fontWeight(.semibold)
                        Text(state.nowPlaying!.subtitle)
                            .font(.subheadline)
                    }
                    Spacer()
                    Symbols.devices
                        .font(.title2)
                    if state.isPlaying {
                        Symbols.pause
                            .font(.title2)
                            .onTapGesture {
                                playerViewModel.pause()
                            }
                    } else {
                        Symbols.play
                            .font(.title2)
                            .onTapGesture {
                                playerViewModel.resume()
                            }
                    }
                }
            })
            .padding(8)
            .background(Theme.onBackground.cornerRadius(10))
            .padding(8)
            .padding(.bottom, router.routes.count >= 1 ? -10 : 45)
            .animation(.easeIn(duration: 0.3), value: router.routes.count >= 1)
        }
        
    }
}

