//
//  ErrorMapper.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 04/06/2023.
//

import Foundation

enum SpotifyError: LocalizedError, Equatable {
    static func == (lhs: SpotifyError, rhs: SpotifyError) -> Bool {
        lhs.compare == rhs.compare
    }
    
    case defaultError(error: Error)
    case invalidUrl
    case invalidResponse
    case invalidData
    
    private var compare: String? {
        switch self {
        case .defaultError:
            return "default"
        case .invalidUrl:
            return "Invalid url"
        case .invalidResponse:
            return "Invalid response"
        case .invalidData:
            return "Invalid data"
        }
    }
}

extension SpotifyError {
    var errorDescription: String? {
        switch self {
        case .defaultError(let error):
            return "An error occured: \(error.localizedDescription)"
        case .invalidUrl:
            return "Invalid url error"
        case .invalidResponse:
            return "Invalid response error"
        case .invalidData:
            return "Invalid data error"
        }
    }
}
