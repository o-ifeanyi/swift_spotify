//
//  HomeFeedEntity.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 16/06/2023.
//

import Foundation

enum FeedType {
    case playlist
    case album
}

struct HomeFeedEntity: Identifiable {
    let id: String
    let title: String
    let data: [HomeFeedData]
}

struct HomeFeedData: Identifiable {
    let id: String
    let type: FeedType
    let url: String
    let header: String
    let subtitle: String
}
