//
//  TrackView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 23/08/2023.
//

import SwiftUI

struct TrackView: View {
    @State var title: String
    @State var subtitle: String
    @State var imageUrl: String?
    
    var body: some View {
        HStack(spacing: 10) {
            if imageUrl != nil {
                AsyncImageView(url: imageUrl, width: 60, height: 60)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(subtitle)
                    .font(.subheadline)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Button(action: {}, label: {
                Symbols.ellipsis
                    .font(.title2)
            })
        }
        .frame(height: 60, alignment: .center)
    }
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackView(title: "Shivers", subtitle: "Ed Sheeran", imageUrl: nil)
    }
}
