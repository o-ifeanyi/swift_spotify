//
//  SearchResultView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 23/08/2023.
//

import SwiftUI

struct SearchResultView: View {
    @State var selectedTab: SearchTabs = .artists
    let gridColumn = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(SearchTabs.allCases, id: \.self) { item in
                        let selected = item == selectedTab
                        
                        PillView(
                            text: item.rawValue,
                            selected: selected,
                            action: {
                                selectedTab = item
                                print(selectedTab)
                            }
                        )
                        .padding(.leading, item == .artists ? 10 : 0)
                    }
                }
            }
            .padding(.vertical, 10)
            switch selectedTab {
            case .artists:
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(0...15, id: \.self) { item in
                        HStack(spacing: 10) {
                            AsyncImageView(url: "https://i.scdn.co/image/ab67616d00001e020ebc17239b6b18ba88cfb8ca", width: 60, height: 60, corenerRadius: 50)
                            
                            Text("Ed SHeeran")
                                .font(.headline)
                                .lineLimit(1)
                            
                            Symbols.checkMark
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(.blue)
                            
                            Spacer()
                            
                            Button(action: {}, label: {
                                Symbols.arrowRight
                                    .font(.title2)
                            })
                        }
                        .frame(height: 60, alignment: .center)
                    }
                }
                .padding(.horizontal, 15)
            case .songs:
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(0...15, id: \.self) {item in
                        TrackView(title: "Shivers", subtitle: "Ed Sheeran", imageUrl: "https://i.scdn.co/image/ab67616d00001e020ebc17239b6b18ba88cfb8ca")
                    }
                }
                .padding(.horizontal, 15)
            case .playlists:
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: gridColumn) {
                        ForEach(0...15, id: \.self) { item in
                            Button(action: {},
                                   label: {
                                VStack(alignment: .leading) {
                                    AsyncImageView(url: "https://i.scdn.co/image/ab67616d00001e020ebc17239b6b18ba88cfb8ca", width: nil)
                                    
                                    Spacer(minLength: 10)
                                    
                                    Text("Ed Sheeran")
                                        .font(.subheadline)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                }
                            })
                        }
                    }
                }
                .padding(.horizontal, 15)
            case .albums:
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: gridColumn) {
                        ForEach(0...15, id: \.self) { item in
                            Button(action: {},
                                   label: {
                                VStack(alignment: .leading) {
                                    AsyncImageView(url: "https://i.scdn.co/image/ab67616d00001e020ebc17239b6b18ba88cfb8ca", width: nil)
                                    
                                    Spacer(minLength: 10)
                                    
                                    Text("Ed Sheeran")
                                        .font(.subheadline)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                }
                            })
                        }
                    }
                }
                .padding(.horizontal, 15)
            }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView()
    }
}

