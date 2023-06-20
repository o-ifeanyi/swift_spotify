//
//  DetailRepositroy.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 18/06/2023.
//

import Foundation

protocol DetailRepository {
    func getAlbum(id: String) async -> Result<AlbumModel, Error>
    func getPlaylist(id: String) async -> Result<PlaylistModel, Error>
}
