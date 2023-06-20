//
//  AuthRepositoryImpl.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 05/06/2023.
//

import SwiftUI

struct Req: Encodable {
    let grantType: String = "client_credentials"
}

final class AuthRepositoryImpl: AuthRepository {
    @Service private var networkManager: NetworkManager
    @Service private var userDefaults: UserDefaults
  
    func getAndSetToken() async -> Result<Bool, Error> {
        do {
            let req: Data = "grant_type=client_credentials".data(using: .utf8)!
            let (data, _) = try await networkManager.request(.token(data: req))
            
            let cred: CredentialModel = try JSONMapper.decode(data)
            userDefaults.set(cred.accessToken, forKey: Constants.token)
            userDefaults.set(Date(timeIntervalSinceNow: Double(cred.expiresIn)), forKey: Constants.tokenExp)
            
            return .success(true)
        } catch {
            print("fail \(error)")
            return .failure(SpotifyError.defaultError(error: error))
        }
    }
}
