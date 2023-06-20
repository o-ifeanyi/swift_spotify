//
//  NewReleasesModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 16/06/2023.
//

import Foundation

struct NewReleasesModel: Codable {
    let albumType: String
    let totalTracks: Int
    let availableMarkets: [String]
    let externalUrls: ExternalUrlsModel
    let id: String
    let href: String
    let images: [ImageModel]
    let name: String
    let releaseDate: String
    let releaseDatePrecision: String
    let restrictions: RestrictionsModel?
    let uri: String
    let type: String
    let copyrights: [CopyrightModel]?
    let externalIds: ExternalIdsModel?
    let genres: [String]?
    let label: String?
    let popularity: Int?
    let albumGroup: String?
    let artists: [ArtistModel]
}
