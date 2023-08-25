//
//  AuthView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 05/06/2023.
//

import SwiftUI

struct AuthScreen: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    
    var body: some View {
        ZStack {
            Theme.background
            VStack {
                LogoView()
                
                Text("Millions of songs.\nFree on Spotify")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    
                
                Button(action: {
                    Task {
                        await authViewModel.getAndSetToken()
                        await homeViewModel.fetchHomeFeed()
                        await homeViewModel.fetchRecommendations()
                    }
                }, label: {
                    HStack {
                        Spacer()
                        if authViewModel.authState.gettingToken || homeViewModel.homeState.gettingHomeFeed {
                            ProgressView()
                        } else {
                            Text("Sign up free")
                                .fontWeight(.bold)
                        }
                        Spacer()
                    }
                    .padding()
                    
                })
                .background(Theme.accent.cornerRadius(30))
                .buttonBorderShape(.capsule)
                .disabled(authViewModel.authState.gettingToken)
            }
            .padding(.horizontal, 15)
        }
        .interactiveDismissDisabled()
        .ignoresSafeArea()
        .overlay(alignment: .bottom) {
            if !authViewModel.authState.gettingTokenErr.isEmpty {
                SnackbarView(text: authViewModel.authState.gettingTokenErr)
            }
        }
    }
}

struct AuthScreen_Previews: PreviewProvider {
    static var previews: some View {
        AuthScreen()
            .environmentObject(Router())
            .environmentObject(HomeViewModel())
            .environmentObject(AuthViewModel())
    }
}
