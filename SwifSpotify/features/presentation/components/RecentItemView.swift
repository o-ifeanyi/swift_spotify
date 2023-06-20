//
//  RecentItemView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 16/06/2023.
//

import SwiftUI

struct RecentItemView: View {
    @EnvironmentObject private var router: Router
    @State var item: RecommendationModel
    
    var body: some View {
        Button(action: {
            router.push(.detail(id: item.album.id, type: "album"))
        }, label: {
            AsyncImageView(url: item.album.images.first?.url, placeholder: Theme.background, width: 60, height: 60)
            
            Text(item.artists.first?.name ?? "")
                .font(.subheadline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
            
            Spacer()
        })
        .background(Theme.onBackground)
        .cornerRadius(5)
    }
}

