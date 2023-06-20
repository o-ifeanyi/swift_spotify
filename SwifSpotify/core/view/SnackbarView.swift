//
//  SnackbarView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 07/06/2023.
//

import SwiftUI

struct SnackbarView: View {
    @State private var isAnimating: Bool = false
    @State var text: String
    @State var isError: Bool = true
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .lineLimit(1...2)
            .multilineTextAlignment(.leading)
            .padding()
            .background(isError ? .red : Theme.accent)
            .cornerRadius(10)
            .opacity(isAnimating ? 1 : 0)
            .offset(y: isAnimating ? -20 : 20)
            .onAppear {
                withAnimation(.easeOut(duration: 0.3)) {
                    isAnimating.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
                    withAnimation(.easeOut(duration: 0.3)) {
                        isAnimating.toggle()
                    }
                })
            }
    }
}

struct SnackbarView_Previews: PreviewProvider {
    static var previews: some View {
        SnackbarView(text: "authViewModel.authState.gettingTokenErr more error becasue why not")
    }
}
