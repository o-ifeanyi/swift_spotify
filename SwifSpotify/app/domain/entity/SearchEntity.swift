//
//  SearchEntity.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 26/08/2023.
//

import Foundation

struct SearchEntity: Identifiable {
    let id: UUID = UUID()
    let tracks: [TrackDataEntity]
    let albums: [HomeFeedData]
    let playlists: [HomeFeedData]
}
