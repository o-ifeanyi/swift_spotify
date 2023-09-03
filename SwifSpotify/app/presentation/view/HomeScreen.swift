//
//  HomeView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 04/06/2023.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var homeViewModel: HomeViewModel
    let gridColumn = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                LazyVGrid(columns: gridColumn) {
                    ForEach(homeViewModel.homeState.recommendations) { item in
                        RecentItemView(item: item)
                    }
                }
                .padding(.horizontal, 15)
                
                ForEach(homeViewModel.homeState.homeFeed) { feed in
                    CategoryView(header: feed.title, data: feed.data)
                }
                
                Spacer(minLength: 20)
            }
        }
        .safeAreaInset(edge: .top) {
            HStack(spacing: 15) {
                PillView(text: "Music", action: {})
                PillView(text: "Podcasts & Shows", action: {})
                Spacer()
            }
            .padding()
            .background(.bar)
        }
        .task {
            if !authViewModel.authState.tokenHasExpired {
                if homeViewModel.homeState.recommendations.isEmpty {
                    await homeViewModel.fetchRecommendations()
                }
                if homeViewModel.homeState.homeFeed.isEmpty {
                    await homeViewModel.fetchHomeFeed()
                }
            }
        }
    }
}
