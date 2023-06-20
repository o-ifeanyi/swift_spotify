//
//  OwnerModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 15/06/2023.
//

import Foundation

struct OwnerModel: Codable {
    let externalUrls: ExternalUrlsModel
    let followers: FollowersModel?
    let href: String
    let id: String
    let type: String
    let uri: String
    let displayName: String
}
