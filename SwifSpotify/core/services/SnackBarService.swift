//
//  SnackBarService.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 02/09/2023.
//

import SwiftUI

struct SnackBarState: Identifiable, Equatable {
    static func == (lhs: SnackBarState, rhs: SnackBarState) -> Bool {
        lhs.id == rhs.id
    }
    
    let id = UUID()
    let hasError: Bool
    let error: Error
}

class SnackBarService: ObservableObject {
    static let shared = SnackBarService()
    
    @Published private (set) var snackBarState: SnackBarState?
    
    @MainActor
    func displayError(_ error: Error) {
        print("GOT HERE")
        snackBarState = nil
        snackBarState = SnackBarState(hasError: true, error: error)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            withAnimation(.easeOut(duration: 0.3)) {
                self.snackBarState = nil
            }
            
            print("GOT HERE TOO")
        })
    }
}
