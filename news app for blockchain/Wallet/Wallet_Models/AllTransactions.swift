//
//  AllTransactions.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 13/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation
import RealmSwift

class AllTransactions:Object{
//    @objc dynamic var id:Int = 0
    @objc dynamic var status = ""
    @objc dynamic var coinName = ""
    @objc dynamic var coinAbbName = ""
    @objc dynamic var exchangName = ""
    @objc dynamic var tradingPairsName = ""
    @objc dynamic var singlePrice:Float = 0
    @objc dynamic var totalPrice:Float = 0
    @objc dynamic var amount:Int = 0
    @objc dynamic var date = ""
    @objc dynamic var time = ""
    @objc dynamic var expenses = ""
    @objc dynamic var additional = ""
    @objc dynamic var usdSinglePrice:Float = 0
    @objc dynamic var usdTotalPrice:Float = 0
    @objc dynamic var audSinglePrice:Float = 0
    @objc dynamic var audTotalPrice:Float = 0
    
//    override class func primaryKey() -> String {
//        return "id"
//    }
}
