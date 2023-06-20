//
//  AuthReposiory.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 05/06/2023.
//

import Foundation

protocol AuthRepository {
    func getAndSetToken() async -> Result<Bool, Error>
}
