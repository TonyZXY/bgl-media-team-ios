//
//  TransactionSearchJson.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 3/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation


import RealmSwift

class TransactionSearchJson: Object {
    @objc dynamic var coinName = ""
    @objc dynamic var coiname = ""
//    @objc dynamic var exchangeMarket = Date()
//    @objc dynamic var contents = ""
    
    override class func primaryKey() -> String {
        return "id"
    }
}
