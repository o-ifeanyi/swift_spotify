//
//  AsyncImageView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 16/06/2023.
//

import SwiftUI

struct AsyncImageView: View {
    @State var url: String?
    @State var placeholder: Color = Theme.onBackground
    @State var width: CGFloat = 160
    @State var height: CGFloat = 160
    
    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { phase in
            if let image = phase.image {
                    image // Display loaded image.
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                } else if phase.error != nil {
                    Color.red // error.
                        .frame(width: width, height: height)
                } else {
                    placeholder  // placeholder.
                        .frame(width: width, height: height)
                }
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView()
    }
}
