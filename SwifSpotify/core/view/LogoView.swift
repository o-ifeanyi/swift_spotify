//
//  LogoView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 08/06/2023.
//

import SwiftUI

struct LogoView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var size: Double = 60.0
    
    var body: some View {
        Image(colorScheme == .dark ? "logo-white" : "logo-black")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
