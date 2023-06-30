//
//  CategoryIconModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 28/06/2023.
//

import Foundation

struct CategoryIconModel: Codable, Identifiable {
    let id: String
    let href: String
    let icons: [ImageModel]
    let name: String
}
