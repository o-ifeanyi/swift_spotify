//
//  Credenttial.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 05/06/2023.
//

import Foundation

struct CredentialModel: Decodable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
}
