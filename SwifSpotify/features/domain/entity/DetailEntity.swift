//
//  DetailEntity.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 18/06/2023.
//

import Foundation

struct DetailEntity: Identifiable {
    let id: String
    let url: String
    let name: String
    let description: String
    let duration: String
    let tracks: [DetailTrackData]
}

struct DetailTrackData: Identifiable {
    let id: String
    let url: String
    let title: String
    let artist: String
    let previewUrl: String
}
