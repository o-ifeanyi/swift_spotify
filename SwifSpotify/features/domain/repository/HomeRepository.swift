//
//  ArtistRepository.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 06/06/2023.
//

import Foundation

protocol HomeRepository {
    func getRecommendations(limit: Int, seedArtists: String, seedGenres: String, seedTracks: String) async -> Result<[RecommendationModel], Error>
    func getFeaturedPlaylist(offset: Int, limit: Int) async -> Result<PaginatedData<PlaylistModel>, Error>
    func getNewRealease(offset: Int, limit: Int) async -> Result<PaginatedData<NewReleasesModel>, Error>
}
