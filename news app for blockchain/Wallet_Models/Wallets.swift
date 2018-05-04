//
//  Wallets.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 2/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation

//import RealmSwift
//
//class NewsFlash: Object{
//    @objc dynamic var id = 0
//    @objc dynamic var dateTime = Date()
//    @objc dynamic var contents = ""
//    
//    override class func primaryKey() -> String {
//        return "id"
//    }
//}

class Wallets: Object{
    @objc dynamic var id = 0
    @objc dynamic var dateTime = Date()
    @objc dynamic var contents = ""
    
    override class func primaryKey() -> String {
        return "id"
    }
}
