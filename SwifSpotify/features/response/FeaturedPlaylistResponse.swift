//
//  FeaturedPlaylistResponse.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 15/06/2023.
//

import Foundation

import Foundation

struct FeaturedPlaylistResponse: Codable {
    let message: String
    let playlists: PaginatedData<PlaylistModel>
}
