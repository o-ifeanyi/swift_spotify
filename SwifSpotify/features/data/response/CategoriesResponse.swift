//
//  CaeroriesResponse.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 28/06/2023.
//

import Foundation

struct CategoryResponse: Codable {
    let categories: PaginatedData<CategoryIconModel>
}
