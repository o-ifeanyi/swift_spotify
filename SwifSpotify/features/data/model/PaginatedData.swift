//
//  PaginatedData.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 15/06/2023.
//

import Foundation

struct PaginatedData<T: Codable>: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [T]?
    
    func toFeaturedPlaylist() -> HomeFeedEntity {
        let data = items as? [PlaylistModel]
        let homeFeedData = data?.map( {HomeFeedData(id: $0.id , type: .playlist, url: $0.images.first?.url ?? "", header: $0.description , subtitle: "" )} ) ?? []
        return HomeFeedEntity(id: "featured_playlist", title: "Featured Playlist", data: homeFeedData)
    }
    
    func toNewReleases() -> HomeFeedEntity {
        let data = items as? [NewReleasesModel]
        let homeFeedData = data?.map( {HomeFeedData(id: $0.id,type: .album, url: $0.images.first?.url ?? "", header: $0.name, subtitle: $0.artists.first?.name ?? "" )} ) ?? []
        return HomeFeedEntity(id: "new_releases", title: "New Releases", data: homeFeedData)
    }
    
    func toCategoryPlaylist() -> [HomeFeedData] {
        let data = items as? [PlaylistModel]
        return data?.map( {HomeFeedData(id: $0.id , type: .playlist, url: $0.images.first?.url ?? "", header: $0.description , subtitle: "" )} ) ?? []
    }
}


