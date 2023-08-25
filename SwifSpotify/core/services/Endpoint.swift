//
//  Endpoint.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 04/06/2023.
//

import SwiftUI

enum Endpoint {
    case token(data: Data)
    case recommendations(limit: Int, seedArtists: String, seedGenres: String, seedTracks: String)
    case featuredPlaylist(offset: Int, limit: Int)
    case newReleases(offset: Int, limit: Int)
    case playlist(id: String)
    case albums(id: String)
    case categories(offset: Int, limit: Int)
    case categoryPlaylists(id: String, offset: Int, limit: Int)
    case search(query: String, offset: Int, limit: Int)
}

extension Endpoint {
    var host: String {
        switch self {
        case .token:
            return "accounts.spotify.com"
        default:
            return "api.spotify.com"
        }
    }
    
    var path: String {
        switch self {
        case .token:
            return "/api/token"
        case .recommendations:
            return "/v1/recommendations"
        case .featuredPlaylist:
            return "/v1/browse/featured-playlists"
        case .newReleases:
            return "/v1/browse/new-releases"
        case .playlist(let id):
            return "/v1/playlists/\(id)"
        case .albums(let id):
            return "/v1/albums/\(id)"
        case .categories:
            return "/v1/browse/categories"
        case .categoryPlaylists(let id, _, _):
            return "/v1/browse/categories/\(id)/playlists"
        case .search:
            return "/v1/search"
        }
    }
    
    var queryItems: [String: String] {
        switch self {
        case .recommendations(let limit, let seedArtists, let seedGenres, let seedTracks):
            return ["limit": "\(limit)", "seed_artists": seedArtists, "seed_genres": seedGenres, "seed_tracks": seedTracks]
        case .featuredPlaylist(let offset, let limit):
            return ["offset":"\(offset)", "limit": "\(limit)"]
        case .newReleases(let offset, let limit):
            return ["offset":"\(offset)", "limit": "\(limit)"]
        case .categories(let offset, let limit):
            return ["country": "NG", "offset":"\(offset)", "limit": "\(limit)"]
        case .categoryPlaylists(_, let offset, let limit):
            return ["offset":"\(offset)", "limit": "\(limit)"]
        case .search(let query, let offset, let limit):
            return ["q": query, "type": "artist,album,playlist,track", "offset":"\(offset)", "limit": "\(limit)"]
        default:
            return [:]
        }
    }
}

extension Endpoint {
    enum MethodType {
        case get
        case post(data: Data?)
    }
}


extension Endpoint {
    var url: URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = host
        urlComponent.path = path
        
        if !queryItems.isEmpty {
            urlComponent.queryItems = queryItems.compactMap { item in
                URLQueryItem(name: item.key, value: item.value)
            }
        }
        
        return urlComponent.url
    }
    
    var type: MethodType {
        switch self {
        case .token(let data):
            return .post(data: data)
        default:
            return .get
        }
    }
    
    var request: URLRequest {
        var request: URLRequest
        
        request = URLRequest(url: url!)
        request.timeoutInterval = 20.0
        
        if path == "/api/token" {
            let requestToken = "\(Secrets.clientId):\(Secrets.clientSecrete)".data(using: .utf8)?.base64EncodedString() ?? ""
            request.setValue("Basic \(requestToken)", forHTTPHeaderField: "Authorization")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        } else {
            @Service var userDefaults: UserDefaults
            let token = userDefaults.string(forKey: Constants.token) ?? ""
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        
        
        switch type {
            
        case .get:
            request.httpMethod = "GET"
        case .post(let data):
            request.httpMethod = "POST"
            if let data = data {
                request.httpBody = data
                return request
            }
        }
        
        return request
    }
}
