//
//  LinearProgressView.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 03/09/2023.
//

import SwiftUI

struct LinearProgressView: View {
    let progress: Double;
    let fullWidth = UIScreen.screenWidth - 30
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: fullWidth, height: 4)
                .foregroundColor(Theme.onBackground)
            RoundedRectangle(cornerRadius: 5)
                .frame(width: (CGFloat(progress) / 29) * fullWidth, height: 4)
                .foregroundColor(.primary.opacity(0.5))
        }
    }
}

struct LinearProgressView_Previews: PreviewProvider {
    static var previews: some View {
        LinearProgressView(progress: 10)
    }
}
