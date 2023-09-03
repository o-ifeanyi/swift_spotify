//
//  Extensions.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 14/06/2023.
//

import SwiftUI
import AVFoundation

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension Color {
    static func random() -> Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

extension CMTime {
  func asString() -> String {
      return String(format: "0:%02d", Int(self.seconds))
  }
}
