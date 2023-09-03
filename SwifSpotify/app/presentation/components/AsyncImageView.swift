//
//  AsyncImageView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 16/06/2023.
//

import SwiftUI

struct AsyncImageView: View {
    let url: String?
    @State var placeholder: Color = Theme.onBackground
    @State var width: CGFloat? = 160
    @State var height: CGFloat? = 160
    @State var corenerRadius: CGFloat = 0
    
    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { phase in
            if let image = phase.image {
                    image // Display loaded image.
                    .resizable()
                    .frame(width: width, height: height)
                    .scaledToFit()
                    .cornerRadius(corenerRadius)
                } else if phase.error != nil {
                    Color.red // error.
                        .frame(width: width, height: height)
                        .cornerRadius(corenerRadius)
                } else {
                    placeholder  // placeholder.
                        .frame(width: width, height: height)
                        .cornerRadius(corenerRadius)
                }
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(url: "")
    }
}
