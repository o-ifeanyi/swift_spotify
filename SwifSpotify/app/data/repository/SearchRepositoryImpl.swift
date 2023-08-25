//
//  SearchRepository.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 28/06/2023.
//

import Foundation

final class SearchRepositoryImpl: SearchRepository {
    func search(query: String, offset: Int, limit: Int) async -> Result<SearchRespone, Error> {
        do {
            let (data, _) = try await networkManager.request(.search(query: query, offset: offset, limit: limit))
            
            let res: SearchRespone = try JSONMapper.decode(data)
            
            return .success(res)
        } catch {
            print("fail \(error)")
            return .failure(SpotifyError.defaultError(error: error))
        }
    }
    
    @Service private var networkManager: NetworkManager
    
    func getCategories(offset: Int, limit: Int) async -> Result<PaginatedData<CategoryIconModel>, Error> {
        do {
            let (data, _) = try await networkManager.request(.categories(offset: offset, limit: limit))
            
            let res: CategoryResponse = try JSONMapper.decode(data)
            
            return .success(res.categories)
        } catch {
            print("fail \(error)")
            return .failure(SpotifyError.defaultError(error: error))
        }
    }
    
    func getCategoryPlaylist(id: String, offset: Int, limit: Int) async -> Result<PaginatedData<PlaylistModel>, Error> {
        do {
            let (data, _) = try await networkManager.request(.categoryPlaylists(id: id, offset: offset, limit: limit))
            
            let res: FeaturedPlaylistResponse = try JSONMapper.decode(data)
            
            return .success(res.playlists)
        } catch {
            print("fail \(error)")
            return .failure(SpotifyError.defaultError(error: error))
        }
    }
}
