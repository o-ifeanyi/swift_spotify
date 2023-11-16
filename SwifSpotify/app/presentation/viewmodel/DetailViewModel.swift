//
//  DetailViewModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 18/06/2023.
//

import Foundation

struct DetailState {
    var gettingPlaylist: Bool = true
    var gettingAlbum: Bool = true
    var detailEntity: DetailEntity?
}

final class DetailViewModel: ObservableObject {
    @Service private var detailRepository: DetailRepository
    @Published private(set) var detailState = DetailState()
    private var snackBarService: SnackBarService
    
    init(_ snackBarService: SnackBarService = .shared) {
        self.snackBarService = snackBarService
    }
    
    @MainActor
    func fetchAlbum(id: String) async {
        detailState.gettingAlbum = true
        
        defer { detailState.gettingAlbum = false }
        
        let res = await detailRepository.getAlbum(id: id)
        switch res {
        case .success(let album):
            detailState.detailEntity = album.toDetailEntity()
        case .failure(let failure):
            snackBarService.displayError(failure)
        }
    }
    @MainActor
    func fetchPlaylist(id: String) async {
        detailState.gettingPlaylist = true
        
        defer { detailState.gettingPlaylist = false }
        
        let res = await detailRepository.getPlaylist(id: id)
        switch res {
        case .success(let playlist):
            detailState.detailEntity = playlist.toDetailEntity()
        case .failure(let failure):
            snackBarService.displayError(failure)
        }
    }
}
