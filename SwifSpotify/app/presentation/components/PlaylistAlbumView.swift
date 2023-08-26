//
//  PlaylistAlbumView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 26/08/2023.
//

import SwiftUI

struct PlaylistAlbumView: View {
    @State var title: String
    @State var imageUrl: String
    @State var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            VStack(alignment: .leading) {
                AsyncImageView(url: imageUrl, width: nil)
                
                Spacer(minLength: 10)
                
                Text(title)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
        })
    }
}
