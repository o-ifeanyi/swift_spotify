//
//  NowPlayingView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 01/09/2023.
//

import SwiftUI

struct NowPlayingScreen: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var playerViewModel: PlayerViewModel
    var body: some View {
        let state = playerViewModel.playerState
        let nowPlaying = state.nowPlaying!
        
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Symbols.arrowDown
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
                Text(nowPlaying.title)
                    .fontWeight(.bold)
                Spacer()
                Symbols.ellipsis
            }
            Spacer()
            AsyncImageView(url: nowPlaying.url, width: UIScreen.screenWidth - 30, height: UIScreen.screenHeight * 0.4)
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    Text(nowPlaying.title)
                        .font(.title2)
                        .lineLimit(1)
                        .fontWeight(.bold)
                    Text(nowPlaying.subtitle)
                        .font(.caption)
                        .lineLimit(1)
                }
                Spacer()
                Symbols.plusCircle
                    .font(.title2)
            }
            VStack {
                LinearProgressView(progress: state.elapsedTime?.seconds ?? 0)
                HStack {
                    Text(state.elapsedTime?.asString() ?? "0:00")
                        .font(.caption)
                    Spacer()
                    Text("0:30")
                        .font(.caption)
                }
            }
            HStack {
                Symbols.shuffle
                    .font(.title2)
                Spacer()
                Symbols.previous
                    .font(.title)
                    .onTapGesture {
                        playerViewModel.prev()
                    }
                Spacer()
                if state.isPlaying {
                    Symbols.pause
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(30)
                        .background(Theme.onBackground.cornerRadius(50))
                        .onTapGesture {
                            playerViewModel.pause()
                        }
                } else {
                    Symbols.play
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(30)
                        .background(Theme.onBackground.cornerRadius(50))
                        .onTapGesture {
                            playerViewModel.resume()
                        }
                }
                Spacer()
                Symbols.next
                    .font(.title)
                    .onTapGesture {
                        playerViewModel.next()
                    }
                Spacer()
                Symbols.remove
                    .font(.title2)
            }
            HStack {
                Symbols.devices
                    .font(.title2)
                Spacer()
                Symbols.share
                    .font(.title2)
            }
        }
        .padding()
        .interactiveDismissDisabled()
    }
}
