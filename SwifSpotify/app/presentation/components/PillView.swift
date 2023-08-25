//
//  PillView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 14/06/2023.
//

import SwiftUI

struct PillView: View {
    @State var text: String
    var selected: Bool = false
    @State var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(text)
                .fontWeight(.semibold)
                .foregroundColor(selected ? .white : nil)
        })
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background(selected ? Theme.accent : Theme.onBackground)
        .cornerRadius(30)
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        PillView(text: "Music", action: {})
    }
}
