//
//  TracksModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 15/06/2023.
//

import Foundation

struct AlbumTracksModel: Codable {
    let artists: [ArtistModel]
    let availableMarkets: [String]
    let discNumber: Int
    let durationMs: Int
    let explicit: Bool
    let externalUrls: ExternalUrlsModel?
    let id: String
    let href: String
    let previewUrl: String?
    let name: String
    let trackNumber: Int
    let uri: String
    let type: String
    let isLocal: Bool
}
