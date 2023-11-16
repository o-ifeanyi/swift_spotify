//
//  HomeViewModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 16/06/2023.
//

import Foundation

struct HomeState {
    var gettingHomeFeed: Bool = false
    var homeFeed: [HomeFeedEntity] = []
    var gettingRecommendations: Bool = false
    var recommendations: [RecommendationModel] = []
}

final class HomeViewModel: ObservableObject {
    @Service private var homerepository: HomeRepository
    @Published var homeState = HomeState()
    private var snackBarService: SnackBarService
    
    init(_ snackBarService: SnackBarService = .shared) {
        self.snackBarService = snackBarService
    }
    
    @MainActor
    func fetchRecommendations() async {

        homeState.gettingRecommendations = true
        defer { homeState.gettingRecommendations = false }
 
        let res = await homerepository.getRecommendations(limit: 6, seedArtists: "4NHQUGzhtTLFvgF5SZesLK", seedGenres: "classical,country", seedTracks: "0c6xIDDpzE81m2q797ordA")
        
        switch res {
        case .success(let data):
            homeState.recommendations = data
        case .failure(let failure):
            snackBarService.displayError(failure)
        }
    }
    
    @MainActor
    func fetchHomeFeed() async {

        homeState.gettingHomeFeed = true
        defer { homeState.gettingHomeFeed = false }
        
        let playlist = await homerepository.getFeaturedPlaylist(offset: 0, limit: 10)
        
        switch playlist {
        case .success(let data):
            homeState.homeFeed.append(data.toFeaturedPlaylist())
        case .failure(let failure):
            snackBarService.displayError(failure)
        }
        
        let newReleases = await homerepository.getNewRealease(offset: 0, limit: 10)
        
        switch newReleases {
        case .success(let data):
            homeState.homeFeed.append(data.toNewReleases())
        case .failure(let failure):
            snackBarService.displayError(failure)
        }
    }
}
