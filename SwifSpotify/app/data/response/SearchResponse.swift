//
//  SearchResponse.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 23/08/2023.
//

import Foundation

struct SearchRespone: Codable {
    let tracks: PaginatedData<TrackObjectModel>
    let albums: PaginatedData<AlbumModel>
    let playlists: PaginatedData<PlaylistModel>
    
    func toSearchEntity() -> SearchEntity {
        let tracks = tracks.items?.map({
            TrackDataEntity(id: $0.id, url: $0.album.images.first?.url ?? "", title: $0.name, subtitle: $0.artists.first?.name ?? "", previewUrl: $0.previewUrl ?? "")
        }) ?? []
        
        let albums = albums.items?.map({
            HomeFeedData(id: $0.id, type: FeedType.album, url: $0.images.first?.url ?? "", header: $0.name, subtitle: $0.artists.first?.name ?? "")
        }) ?? []
        
        let playlists = playlists.items?.map({
            HomeFeedData(id: $0.id, type: FeedType.playlist, url: $0.images.first?.url ?? "", header: $0.name, subtitle: $0.description)
        }) ?? []
        
        return SearchEntity(tracks: tracks, albums: albums, playlists: playlists)
    }
}
