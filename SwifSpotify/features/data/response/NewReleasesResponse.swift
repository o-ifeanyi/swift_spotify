//
//  NewReleasesResponse.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 16/06/2023.
//

import Foundation

struct NewReleasesResponse: Codable {
    let albums: PaginatedData<NewReleasesModel>
}

