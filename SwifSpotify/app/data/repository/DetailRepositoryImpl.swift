//
//  DetailRepositoryImpl.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 18/06/2023.
//

import Foundation

final class DetailRepositoryImpl: DetailRepository {
    @Service private var networkManager: NetworkManager
    
    func getAlbum(id: String) async -> Result<AlbumModel, Error> {
        do {
            let (data, _) = try await networkManager.request(.albums(id: id))
            
            let res: AlbumModel = try JSONMapper.decode(data)
            
            return .success(res)
        } catch {
            print("fail \(error)")
            return .failure(SpotifyError.defaultError(error: error))
        }
    }
    
    func getPlaylist(id: String) async -> Result<PlaylistModel, Error> {
        do {
            let (data, _) = try await networkManager.request(.playlist(id: id))
            
            let res: PlaylistModel = try JSONMapper.decode(data)
            
            return .success(res)
        } catch {
            print("fail \(error)")
            return .failure(SpotifyError.defaultError(error: error))
        }
    }
}
