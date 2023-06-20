//
//  DetailViewModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 18/06/2023.
//

import Foundation

struct DetailState {
    var gettingPlaylist: Bool = true
    var gettingPlaylistErr: String = ""
    
    var gettingAlbum: Bool = true
    var gettingAlbumErr: String = ""
    
    var detailEntity: DetailEntity?
}

final class DetailViewModel: ObservableObject {
    @Service private var detailRepository: DetailRepository
    @Published private(set) var detailState = DetailState()
    
    @MainActor
    func fetchAlbum(id: String) async {
        detailState.gettingAlbumErr = ""
        detailState.gettingAlbum = true
        
        defer { detailState.gettingAlbum = false }
        
        let res = await detailRepository.getAlbum(id: id)
        switch res {
        case .success(let album):
            detailState.detailEntity = album.toDetailEntity()
        case .failure(let failure):
            detailState.gettingAlbumErr = failure.localizedDescription
        }
    }
    @MainActor
    func fetchPlaylist(id: String) async {
        detailState.gettingPlaylistErr = ""
        detailState.gettingPlaylist = true
        
        defer { detailState.gettingPlaylist = false }
        
        let res = await detailRepository.getPlaylist(id: id)
        switch res {
        case .success(let playlist):
            detailState.detailEntity = playlist.toDetailEntity()
        case .failure(let failure):
            detailState.gettingPlaylistErr = failure.localizedDescription
        }
    }
}
