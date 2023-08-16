//
//  SearchReposiory.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 28/06/2023.
//

import Foundation

protocol SearchRepository {
    func getCategories(offset: Int, limit: Int) async -> Result<PaginatedData<CategoryIconModel>, Error>
    
    func getCategoryPlaylist(id: String, offset: Int, limit: Int) async -> Result<PaginatedData<PlaylistModel>, Error>
}
