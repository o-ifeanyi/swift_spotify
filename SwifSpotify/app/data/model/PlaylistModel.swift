//
//  PlaylistModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 15/06/2023.
//

import Foundation

struct PlaylistModel: Codable, Identifiable {
    let description: String
    let externalUrls: ExternalUrlsModel?
    let href: String
    let id: String
    let images: [ImageModel]
    let name: String
    let owner: OwnerModel?
    let type: String
    let uri: String
    let tracks: PaginatedData<PlaylistTrackModel>?
    
    func toDetailEntity() -> DetailEntity {
        let trackData = tracks?.items?.map( { TrackDataEntity(id: $0.track.id, url: $0.track.album.images.last?.url ?? "", title: $0.track.name, subtitle: $0.track.artists.first?.name ?? "", previewUrl: $0.track.previewUrl ?? "") } )
        
        var time = 0
        for i in tracks?.items ?? [] {
            time += i.track.durationMs
        }
        
        return DetailEntity(id: id, url: images.first?.url ?? "", name: name, description: description, duration: "\(time)", tracks: trackData ?? [])
    }
}
