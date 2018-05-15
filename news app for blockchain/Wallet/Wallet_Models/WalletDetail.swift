//
//  WalletDetail.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 14/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation

class WalletDetail {
    var coinName:String = ""
    var coinAbbName:String = ""
    var coinAmount:Int = 0
    var TransactionPrice:Float = 0
    var TotalPrice:Float = 0
    var SinglePrice:Float = 0
    var riseFall:Float = 0
    var percent:String = "0"
    var tradingPairsName:String = ""
    var exchangeName:String = ""
    var logoUrl:String = ""
    var currentSinglePrice:Float = 0
    var currentTotalPrice:Float = 0
    var riseFallPrice:Float = 0
    var riseFallPercent:Float = 0
}

class CaculateResult {
    var single:Float = 0
    var total:Float = 0
    var profit:Float = 0
}
