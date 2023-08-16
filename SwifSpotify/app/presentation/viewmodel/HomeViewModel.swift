//
//  HomeViewModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 16/06/2023.
//

import Foundation

struct HomeState {
    var gettingHomeFeed: Bool = false
    var gettingHomeFeedErr: String = ""
    var homeFeed: [HomeFeedEntity] = []
    
    var gettingRecommendations: Bool = false
    var gettingRecommendationsErr: String = ""
    var recommendations: [RecommendationModel] = []
}

final class HomeViewModel: ObservableObject {
    @Service private var homerepository: HomeRepository
    @Published var homeState = HomeState()
    
    @MainActor
    func fetchRecommendations() async {

        homeState.gettingRecommendationsErr = ""
        homeState.gettingRecommendations = true
        defer { homeState.gettingRecommendations = false }
 
        let res = await homerepository.getRecommendations(limit: 6, seedArtists: "4NHQUGzhtTLFvgF5SZesLK", seedGenres: "classical,country", seedTracks: "0c6xIDDpzE81m2q797ordA")
        
        switch res {
        case .success(let data):
            homeState.recommendations = data
        case .failure(let failure):
            homeState.gettingRecommendationsErr = failure.localizedDescription
        }
    }
    
    @MainActor
    func fetchHomeFeed() async {

        homeState.gettingHomeFeedErr = ""
        homeState.gettingHomeFeed = true
        defer { homeState.gettingHomeFeed = false }
        
        let playlist = await homerepository.getFeaturedPlaylist(offset: 0, limit: 10)
        
        switch playlist {
        case .success(let data):
            homeState.homeFeed.append(data.toFeaturedPlaylist())
        case .failure(let failure):
            homeState.gettingHomeFeedErr = failure.localizedDescription
        }
        
        let newReleases = await homerepository.getNewRealease(offset: 0, limit: 10)
        
        switch newReleases {
        case .success(let data):
            homeState.homeFeed.append(data.toNewReleases())
        case .failure(let failure):
            homeState.gettingHomeFeedErr = failure.localizedDescription
        }
    }
}
