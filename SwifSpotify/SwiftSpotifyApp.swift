//
//  SwifSpotifyApp.swift
//  SwifSpotify
//
//  Created by Ifeanyi Onuoha on 04/06/2023.
//

import SwiftUI

@main
struct SwiftSpotifyApp: App {
    
    init() {
        setupServiceContainer()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Router())
                .environmentObject(AuthViewModel())
                .environmentObject(HomeViewModel())
                .environmentObject(DetailViewModel())
                .environmentObject(SearchViewModel())
                .environmentObject(PlayerViewModel())
        }
    }
}

private extension SwiftSpotifyApp {
    
    func setupServiceContainer() {
        // Services
        ServiceContainer.register(type: URLSession.self, .shared)
        ServiceContainer.register(type: UserDefaults.self, .standard)
        ServiceContainer.register(type: NetworkManager.self, NetworkManagerImpl())
        
        // Repositories
        ServiceContainer.register(type: AuthRepository.self, AuthRepositoryImpl())
        ServiceContainer.register(type: HomeRepository.self, HomeRepositoryImpl())
        ServiceContainer.register(type: DetailRepository.self, DetailRepositoryImpl())
        ServiceContainer.register(type: SearchRepository.self, SearchRepositoryImpl())
    }
}
