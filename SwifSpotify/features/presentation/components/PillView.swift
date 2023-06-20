//
//  PillView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 14/06/2023.
//

import SwiftUI

struct PillView: View {
    @State var text: String
    @State var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(text)
        })
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background(Theme.onBackground.cornerRadius(30))
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        PillView(text: "Music", action: {})
    }
}
