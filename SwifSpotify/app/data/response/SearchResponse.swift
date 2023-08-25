//
//  SearchResponse.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 23/08/2023.
//

import Foundation

struct SearchRespone: Codable {
    let tracks: PaginatedData<TrackObjectModel>
    let artists: PaginatedData<ArtistModel>
    let albums: PaginatedData<AlbumModel>
    let playlists: PaginatedData<PlaylistModel>
}
