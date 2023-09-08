//
//  AuthViewModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 05/06/2023.
//

import Foundation

struct AuthState {
    var gettingToken: Bool = false
    var tokenHasExpired: Bool = false
}

final class AuthViewModel: ObservableObject {
    @Service private var authRepository: AuthRepository
    @Service private var userDefaults: UserDefaults
    @Published var authState = AuthState()
    private var snackBarService: SnackBarService
    
    init(_ snackBarService: SnackBarService) {
        self.snackBarService = snackBarService
    }
    
    func validateToken() {
        let date = userDefaults.object(forKey: Constants.tokenExp)
        guard let tokenExp = date as? Date else {
            authState.tokenHasExpired =  true
            return
        }
        
        authState.tokenHasExpired = tokenExp.timeIntervalSinceNow < 0
    }
    
    @MainActor
    func getAndSetToken() async {

        authState.gettingToken = true
        defer { authState.gettingToken = false }
        
        let res = await authRepository.getAndSetToken()
        validateToken()
        
        switch res {
        case .success(_): break
        case .failure(let failure):
            snackBarService.displayError(failure)
        }
    }
}
