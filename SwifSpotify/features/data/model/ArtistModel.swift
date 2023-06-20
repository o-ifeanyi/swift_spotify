//
//  ArtistModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 04/06/2023.
//

import Foundation

import Foundation

struct ArtistModel: Codable {
    let externalUrls: ExternalUrlsModel
    let followers: FollowersModel?
    let genres: [String]?
    let href: String
    let id: String
    let images: [ImageModel]?
    let name: String
    let popularity: Int?
    let uri: String
    let type: String
}



