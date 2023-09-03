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
    let tracks: [TrackDataEntity]
}

struct TrackDataEntity: Identifiable, Equatable {
    let id: String
    let url: String
    let title: String
    let subtitle: String
    let previewUrl: String
}
