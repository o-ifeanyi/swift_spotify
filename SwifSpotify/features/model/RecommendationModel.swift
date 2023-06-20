//
//  RecommendationModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 17/06/2023.
//

import Foundation

struct RecommendationModel: Codable, Identifiable {
    let album: AlbumModel
    let artists: [ArtistModel]
    let availableMarkets: [String]
    let discNumber: Int
    let durationMs: Int
    let explicit: Bool
    let externalIDS: ExternalIdsModel?
    let externalUrls: ExternalUrlsModel
    let href: String
    let name: String
    let id: String
    let popularity: Int
    let previewURL: String?
    let trackNumber: Int
    let uri: String
    let type: String
    let isLocal: Bool
}


