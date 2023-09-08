//
//  ContentView.swift
//  SwifSpotify
//
//  Created by Ifeanyi Onuoha on 04/06/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var theme
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var snackBarService: SnackBarService
    @State private var showNowPlaying: Bool = false
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationStack(path: $router.routes) {
                TabView(selection: $router.selectedTab) {
                    HomeScreen()
                        .onTapGesture { router.selectedTab = .home }
                        .tabItem {
                            Symbols.home
                            Text("Home")
                        }
                        .tag(Tabs.home)
                    
                    SearchScreen()
                        .onTapGesture { router.selectedTab = .search }
                        .tabItem {
                            Symbols.search
                            Text("Search")
                        }
                        .tag(Tabs.search)
                    
                    SubscriptionScreen()
                        .onTapGesture { router.selectedTab = .subscription }
                        .tabItem {
                            if theme == .dark {
                                Symbols.subscriptionDark
                            } else {
                                Symbols.subscriptionLight
                            }
                            Text("Premium")
                        }
                        .tag(Tabs.subscription)
                }
                .toolbar {
                    switch router.selectedTab {
                    case .home:
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("Good afternoon")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Symbols.bell
                            
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Symbols.clock
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Symbols.setting
                        }
                    case .search:
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("Search")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Symbols.camera
                        }
                    case .subscription:
                        ToolbarItem {
                            
                        }
                    }
                }
                .onAppear {
                    authViewModel.validateToken()
                }
                .sheet(isPresented: $authViewModel.authState.tokenHasExpired) {
                    AuthScreen()
                }
                .sheet(isPresented: $showNowPlaying) {
                    NowPlayingScreen()
                }
                .navigationDestination(for: Route.self, destination: { $0 })
            }
            PlayerView {
                showNowPlaying.toggle()
            }
        }
        .overlay(alignment: .top) {
            if (snackBarService.snackBarState?.hasError == true) {
                SnackbarView(text: snackBarService.snackBarState?.error.localizedDescription ?? "An error occured")
            }
        }
    }
}

