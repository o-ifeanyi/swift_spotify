//
//  AlbumModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 17/06/2023.
//

import Foundation

struct AlbumModel: Codable, Identifiable {
    let albumType: String
    let totalTracks: Int
    let availableMarkets: [String]
    let externalUrls: ExternalUrlsModel?
    let href: String
    let id: String
    let images: [ImageModel]
    let name: String
    let releaseDate: String
    let releaseDatePrecision: String
    let label: String?
    let type: String
    let albumGroup: String?
    let uri: String
    let artists: [ArtistModel]
    let tracks: PaginatedData<AlbumTracksModel>?
    
    func toDetailEntity() -> DetailEntity {
        let trackData = tracks?.items?.map( { DetailTrackData(id: $0.id, url: "", title: $0.name, artist: $0.artists.first?.name ?? "", previewUrl: $0.previewUrl ?? "") } )
        
        var time = 0
        for i in tracks?.items ?? [] {
            time += i.durationMs
        }
        
        return DetailEntity(id: id, url: images.first?.url ?? "", name: artists.first?.name ?? "", description: label ?? "", duration: "\(time)", tracks: trackData ?? [])
    }
}
