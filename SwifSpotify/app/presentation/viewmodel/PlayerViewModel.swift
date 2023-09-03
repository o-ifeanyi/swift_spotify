//
//  NowPlayingViewModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 02/09/2023.
//

import SwiftUI
import AVFoundation

struct PlayerState {
    var isPlaying: Bool = false
    var elapsedTime: CMTime?
    var nowPlaying: TrackDataEntity?
    var queue: [TrackDataEntity] = []
}

class PlayerViewModel: ObservableObject {
    @Published private(set) var playerState = PlayerState()
    private var audioPlayer: AVPlayer?
    
    @MainActor
    func listen() {
        let interval = CMTime(seconds: 1,
                              preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        audioPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.playerState.elapsedTime = time
            if Int(time.seconds) == 29 {
                self?.next()
            }
        }
    }
    
    
    @MainActor
    func play(_ track: TrackDataEntity) {
        if let url = URL(string: track.previewUrl) {
            if track != playerState.nowPlaying {
                playerState.elapsedTime = nil
            }
            audioPlayer = AVPlayer(url: url)
            audioPlayer?.seek(to: playerState.elapsedTime ?? .zero, toleranceBefore: .zero, toleranceAfter: .zero)
            audioPlayer?.play()
            audioPlayer?.actionAtItemEnd = .pause
            playerState.nowPlaying = track
            playerState.isPlaying = true
            listen()
        }
    }
    
    func setQueue(val: [TrackDataEntity]) {
        playerState.queue = val
    }
    
    @MainActor
    func resume() {
        if let nowPlaying = playerState.nowPlaying {
            play(nowPlaying)
        }
    }
    
    @MainActor
    func pause() {
        guard audioPlayer != nil else {
            return
        }
        audioPlayer!.pause()
        playerState.isPlaying = false
    }
    
    @MainActor
    func prev() {
        guard playerState.nowPlaying != nil && !playerState.queue.isEmpty else {
            return
        }
        if let index = playerState.queue.firstIndex(where: { $0 == playerState.nowPlaying }) {
            if index > 0 {
                play(playerState.queue[index - 1])
            } else {
                play(playerState.queue[0])
            }
        }
    }
    
    @MainActor
    func next() {
        guard playerState.nowPlaying != nil && !playerState.queue.isEmpty else {
            return
        }
        if let index = playerState.queue.firstIndex(where: { $0 == playerState.nowPlaying }) {
            if index < playerState.queue.count - 1 {
                play(playerState.queue[index + 1])
            } else {
                play(playerState.queue[0])
            }
        }
    }
}
