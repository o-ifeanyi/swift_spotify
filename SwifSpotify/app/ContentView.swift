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
    
    
    var body: some View {
        ZStack {
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
                .navigationDestination(for: Route.self, destination: { $0 })
            }
            // media player
        }
    }
}

