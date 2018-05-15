//
//  Wallets.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 2/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation

import RealmSwift

class Wallet: Object{
    @objc dynamic var coinName = ""
    @objc dynamic var exchangName = ""
    @objc dynamic var priceChange = ""
    @objc dynamic var coinAbbName = ""
    @objc dynamic var tradingPairsName = ""
    @objc dynamic var coinAmount:Int = 0
    @objc dynamic var totalPrice:Float = 0
    @objc dynamic var singlePrice:Float = 0
    
    
    override class func primaryKey() -> String {
        return "coinName"
    }
}
