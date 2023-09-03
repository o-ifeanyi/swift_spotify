//
//  AppState.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 02/09/2023.
//

import Foundation

struct ErrorWrapper: Identifiable, Equatable {
    static func == (lhs: ErrorWrapper, rhs: ErrorWrapper) -> Bool {
        lhs.id == rhs.id
    }
    
    let id = UUID()
    let error: Error
}

class AppState: ObservableObject {
    @Published private (set) var errorWrapper: ErrorWrapper?
    
    @MainActor
    func displayError(_ error: Error) {
        errorWrapper = nil
        errorWrapper = ErrorWrapper(error: error)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            self.errorWrapper = nil
        })
    }
}
