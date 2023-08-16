//
//  SubscriptionView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 04/06/2023.
//

import SwiftUI

struct SubscriptionView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 10) {
                Text("1 month of Premium for free")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                TabView {
                    ForEach(subOffers) { item in
                        SubOfferView(offer: item)
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 200)
                
                
                Text("You can't upgrade to Premium in the app. We know, it's not ideal.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                
                GroupBox {
                    HStack {
                        Text("Spotify Free")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Text("CURRENT PLAN")
                    }
                    .padding(10)
                }
                
                ForEach(subModels) { item in
                    SubCardView(sub: item)
                }
            }
        }
        .padding()
    }
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView()
    }
}
