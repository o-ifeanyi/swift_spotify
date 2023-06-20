//
//  ArtistRepositoryImpl.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 06/06/2023.
//

import SwiftUI

final class HomeRepositoryImpl: HomeRepository {
    @Service private var networkManager: NetworkManager
    
    func getRecommendations(limit: Int, seedArtists: String, seedGenres: String, seedTracks: String) async -> Result<[RecommendationModel], Error> {
        do {
            let (data, _) = try await networkManager.request(.recommendations(limit: limit, seedArtists: seedArtists, seedGenres: seedGenres, seedTracks: seedTracks))
            
            let res: RecommendationResponse = try JSONMapper.decode(data)
            
            return .success(res.tracks)
        } catch {
            print("fail \(error)")
            return .failure(SpotifyError.defaultError(error: error))
        }
    }

    func getFeaturedPlaylist(offset: Int, limit: Int) async -> Result<PaginatedData<PlaylistModel>, Error> {
        do {
            let (data, _) = try await networkManager.request(.featuredPlaylist(offset: offset, limit: limit))
            
            let res: FeaturedPlaylistResponse = try JSONMapper.decode(data)
            
            return .success(res.playlists)
        } catch {
            print("fail \(error)")
            return .failure(SpotifyError.defaultError(error: error))
        }
    }
    
    func getNewRealease(offset: Int, limit: Int) async -> Result<PaginatedData<NewReleasesModel>, Error> {
        do {
            let (data, _) = try await networkManager.request(.newReleases(offset: offset, limit: limit))
            
            let res: NewReleasesResponse = try JSONMapper.decode(data)
            
            return .success(res.albums)
        } catch {
            print("fail \(error)")
            return .failure(SpotifyError.defaultError(error: error))
        }
    }
}

