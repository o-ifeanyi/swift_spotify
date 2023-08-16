//
//  NetworkManager.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 06/06/2023.
//

import Foundation

protocol NetworkManager {
    func request(_ endpoint: Endpoint) async throws -> (Data, URLResponse)
}
