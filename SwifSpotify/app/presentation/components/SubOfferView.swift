//
//  SubOfferView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 27/06/2023.
//

import SwiftUI

struct SubOfferView: View {
    @Environment(\.colorScheme) private var theme
    let offer: SubOfferModel
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                Text("FREE")
                    .foregroundColor(.white)
                Spacer()
                Text(offer.free)
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .frame(width: UIScreen.screenWidth * 0.35, height: 130)
            .padding(10)
            .background(theme == .dark ? Theme.onBackground : .gray)
             
            VStack {
                Text("PREMIUM")
                    .foregroundColor(.white)
                Spacer()
                Text(offer.premium)
                    .font(.title3)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .frame(width: UIScreen.screenWidth * 0.35, height: 130)
            .padding(10)
            .background(offer.gradient)
        }
        .cornerRadius(8)
        .padding(.bottom, 50)
        
    }
}

struct SubOfferView_Previews: PreviewProvider {
    static var previews: some View {
        SubOfferView(offer: subOffers[3])
    }
}
