//
//  SubCardView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 27/06/2023.
//

import SwiftUI

struct SubCardView: View {
    let sub: SubscriptionModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if sub.tag != nil {
                Text(sub.tag!)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .padding(10)
                    .background(.white.opacity(0.7))
                    .cornerRadius(4)
            }
            
            VStack(spacing: 20) {
                
                Text(sub.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Spacer()
                    Text(sub.subtitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
        }
        .padding()
        .background(sub.gradient)
        .cornerRadius(8)
        .padding(.vertical, 8)
    }
}

struct SubCardView_Previews: PreviewProvider {
    static var previews: some View {
        SubCardView(sub: subModels[0])
    }
}
