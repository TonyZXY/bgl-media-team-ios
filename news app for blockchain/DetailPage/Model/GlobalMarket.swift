//
//  GlobalMarket.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 27/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation


struct MarketAllData:Decodable{
    var data:CoinAllDetails?
    var metadata:MetaDatas?
}

struct CoinAllDetails:Decodable{
    var id:Int?
    var name:String?
    var symbol:String?
    var website_slug:String?
    var rank:Int?
    var circulating_supply:Double?
    var total_supply:Double?
    var max_supply:Double?
    var quotes:[String:Quotes]
    var last_updated:Int?
}

struct Quotes:Decodable{
    var price:Double?
    var volume_24h:Double?
    var market_cap:Double?
    var percent_change_1h:Double?
    var percent_change_24h:Double?
    var percent_change_7d:Double?
}


struct MetaDatas:Decodable{
    var timestamp:Int?
    var error:String?
}

class GlobalMarket {
    let id:Int?
    let symbol:String?
    let name:String?
    let circulating_supply:Double?
    let percent_change_1h:Double?
    let percent_change_24h:Double?
    let percent_change_7d:Double?
    let price:Double?
    let volume_24h:Double?
    let market_cap:Double?
//
//    struct CoinKeys {
//        static let id = "id"
//        static let symbol = "symbol"
//        static let name = "symbol"
//        static let circulating_supply = "circulating_supply"
//        static let aud_percent_change_1h = "percent_change_1h"
//        static let aud_percent_change_24h = "percent_change_24h"
//        static let aud_percent_change_7d = "percent_change_7d"
//        static let aud_price = "price"
//        static let aud_volume_24h = "volume_24h"
//        static let aud_market_cap = "market_cap"
//        static let usd_price = "price"
//        static let usd_volume_24h = "volume_24h"
//        static let usd_market_cap = "market_cap"
//    }

    init() {
        id = 0
        symbol = ""
        name = ""
        circulating_supply = 0
        percent_change_1h = 0
        percent_change_24h = 0
        percent_change_7d = 0
        price = 0
        volume_24h = 0
        market_cap = 0
    }
    
    
    init(market:MarketAllData,priceType:String) {
        let marketData = market.data
        let quote = marketData?.quotes
        id = marketData?.id
        symbol = marketData?.symbol
        name = marketData?.name
        circulating_supply = marketData?.circulating_supply
        percent_change_1h = quote![priceType]?.percent_change_1h
        percent_change_24h = quote![priceType]?.percent_change_24h
        percent_change_7d = quote![priceType]?.percent_change_7d
        price = quote![priceType]?.price
        volume_24h = quote![priceType]?.volume_24h
        market_cap = quote![priceType]?.market_cap
    }
}
