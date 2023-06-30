//
//  CategoryPlaylistView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 30/06/2023.
//

import SwiftUI

struct CategoryPlaylistView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var searchViewModel: SearchViewModel
    @State var id: String
    @State var title: String
    
    let gridColumn = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        let state = searchViewModel.searchState
        
        VStack {
            if state.gettingCategoryPlaylist {
                EmptyView()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    Spacer(minLength: 20)
                    LazyVGrid(columns: gridColumn) {
                        ForEach(state.categoryPlaylist) { item in
                            Button(action: {
                                router.push(.detail(id: item.id, type: "\(item.type)"))
                            }, label: {
                                VStack(alignment: .leading) {
                                    AsyncImageView(url: item.url, width: nil)
                                    
                                    Spacer(minLength: 10)
                                    
                                    Text(item.header)
                                        .font(.subheadline)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                }
                            })
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.large)
        .task {
            await searchViewModel.fetchCategoryPlaylists(id: id)
        }
    }
}

struct CategoryPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPlaylistView(id: "", title: "Afro")
            .environmentObject(SearchViewModel())
    }
}
