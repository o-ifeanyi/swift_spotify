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

enum Route {
    case home
    case detail(id: String, type: String)
}

extension Route: View {
    var body: some View {
        switch self {
        case .home:
            ContentView()
        case .detail(let id, let type):
            DetailView(id: id, type: type)
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
        }
    }
}
