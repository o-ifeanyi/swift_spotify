//
//  Route.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 06/06/2023.
//

import SwiftUI

enum Tabs {
    case home, search, subscription
}

enum SearchTabs: String, CaseIterable {
    case artists = "Artists"
    case songs = "Songs"
    case playlists = "Playlists"
    case albums = "Albums"
}

enum Route {
    case home
    case detail(id: String, type: String)
    case categoryPlaylist(id: String, title: String)
}

extension Route: View {
    var body: some View {
        switch self {
        case .home:
            ContentView()
        case .detail(let id, let type):
            DetailScreen(id: id, type: type)
        case .categoryPlaylist(let id, let title):
            CategoryPlaylistScreen(id: id, title: title)
        }
    }
}

extension Route: Hashable {
    static func == (lhs: Route, rhs: Route) -> Bool {
        return lhs.compareString == rhs.compareString
    }
    
    var compareString: String {
        switch self {
        case .home:
            return "home"
        case .detail:
            return "detail"
        case .categoryPlaylist:
            return "categoryPlaylist"
        }
    }
}
