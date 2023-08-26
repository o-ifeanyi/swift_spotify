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
    
    func toSearchEntity() -> SearchEntity {
        let tracks = tracks.items?.map({
            TrackDataEntity(id: $0.id, url: $0.album.images.first?.url ?? "", title: $0.name, subtitle: $0.artists.first?.name ?? "", previewUrl: $0.previewUrl ?? "")
        }) ?? []
        
        let artists = artists.items?.map({
            TrackDataEntity(id: $0.id, url: $0.images?.first?.url ?? "", title: $0.name, subtitle: "", previewUrl: "")
        }) ?? []
        
        let albums = albums.items?.map({
            TrackDataEntity(id: $0.id, url: $0.images.first?.url ?? "", title: $0.name, subtitle: $0.artists.first?.name ?? "",previewUrl: "")
        }) ?? []
        
        let playlists = playlists.items?.map({
            TrackDataEntity(id: $0.id, url: $0.images.first?.url ?? "", title: $0.name, subtitle: $0.description,previewUrl: "")
        }) ?? []
        
        return SearchEntity(tracks: tracks, artists: artists, albums: albums, playlists: playlists)
    }
}
