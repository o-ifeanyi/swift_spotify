//
//  RecommendationResponse.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 17/06/2023.
//

import Foundation
struct RecommendationResponse: Codable {
    let tracks: [RecommendationModel]
}
