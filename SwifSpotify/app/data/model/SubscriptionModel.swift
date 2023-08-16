//
//  SubscriptionModel.swift
//  SwiftSpotify
//
//  Created by Ifeanyi Onuoha on 27/06/2023.
//

import SwiftUI

struct SubscriptionModel: Identifiable {
    let id: Int
    let tag: String?
    let title: String
    let subtitle: String
    let color1: Color
    let color2: Color
    
    var gradient: LinearGradient {
        return LinearGradient(
            colors: [color1, color2],startPoint: .topLeading, endPoint: .bottomTrailing
        )
    }
}

struct SubOfferModel: Identifiable {
    let id: Int
    let free: String
    let premium: String
    let color1: Color = Color("Gradient1")
    let color2: Color = Color("Gradient2")
    
    var gradient: LinearGradient {
        return LinearGradient(
            colors: [color1, color2], startPoint: .topLeading, endPoint: .bottomTrailing
        )
    }
}

let subOffers = [
    SubOfferModel(id: 0, free : "Ad breaks", premium : "Ad-free music listening"),
    SubOfferModel(id: 1, free : "Play in shuffle", premium : "Play in any order"),
    SubOfferModel(id: 2, free : "Basic sound quality", premium : "Premium sound quality"),
    SubOfferModel(id: 3, free : "Streaming only", premium : "Offline listening")
]

let subModels = [
    SubscriptionModel(
        id: 0,
        tag: "FREE FOR 1 MONTH",
        title: "Premium Individual",
        subtitle:"1 month of Premium for free • Ad-free music listening • Download to listen offline • Play songs in any order • Higher sound quality • Cancel anytime",
        color1: Color("Gradient1"),
        color2: Color("Gradient2")
    ),
    SubscriptionModel(
        id: 1,
        tag : "FREE FOR 1 MONTH",
        title : "Premium Student",
        subtitle : "1 month of Premium for free • Ad-free music listening • Download to listen offline • Play songs in any order • Higher sound quality • Cancel anytime",
        color1 : Color("Gradient3"),
        color2 : Color("Gradient4")
    ),
    SubscriptionModel(
        id: 2,
        tag : "FREE FOR 1 MONTH",
        title : "Premium Duo",
        subtitle : "1 month of Premium for free • 2 Premium accounts • Ad-free music listening • Download to listen offline • Play songs in any order • Higher sound quality • Cancel anytime",
        color1 : Color("Gradient5"),
        color2 : Color("Gradient6")
    ),
    SubscriptionModel(
        id: 3,
        tag : "FREE FOR 1 MONTH",
        title : "Premium Family",
        subtitle : "1 month of Premium for free • Up to 6 Premium accounts • Block explicit music • Ad-free music listening • Download to listen offline • Play songs in any order • Higher sound quality • Cancel anytime",
        color1 : Color("Gradient7"),
        color2 : Color("Gradient8")
    ),
    SubscriptionModel(
        id: 4, 
        tag : nil,
        title : "Premium Prepaid",
        subtitle : "Choose from 1, 3, 6, or 12 months of Premium • Top up when you want",
        color1 : Color("Gradient9"),
        color2 : Color("Gradient10")
    ),
]
