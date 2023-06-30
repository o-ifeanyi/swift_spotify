//
//  CategoryView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 14/06/2023.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject private var router: Router
    @State var header: String
    @State var data: [HomeFeedData]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(data) { item in
                        Button(action: {
                            router.push(.detail(id: item.id, type: "\(item.type)"))
                        }, label: {
                            VStack(alignment: .leading) {
                                AsyncImageView(url: item.url)
                                
                                Spacer(minLength: 10)
                                
                                switch item.type {
                                case .playlist:
                                    Text(item.header)
                                        .font(.subheadline)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                case .album:
                                    Text("\(item.header)")
                                        .font(.subheadline)
                                        .multilineTextAlignment(.leading)
                                        .fontWeight(.semibold)
                                        .lineLimit(1)
                                    Text("Album • \(item.subtitle)")
                                        .multilineTextAlignment(.leading)
                                        .font(.subheadline)
                                        .lineLimit(1)
                                
                                }
                            }
                            .frame(width: 160)
                        })
                    }
                }
                .padding(.horizontal, 15)
            }
        }
    }
}
