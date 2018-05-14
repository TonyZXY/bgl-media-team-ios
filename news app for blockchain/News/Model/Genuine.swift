//
//  Genuine.swift
//  news app for blockchain
//
//  Created by Xuyang Zheng on 9/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift

class Genuine : Object, Decodable {
    @objc dynamic var _id: String? = ""
    @objc dynamic var title: String? = ""
    @objc dynamic var genuineDescription: String? = ""
    @objc dynamic var imageURL: String? = ""
    @objc dynamic var detail: String? = ""
    @objc dynamic var publishedTime: String? = ""
    @objc dynamic var author: String? = ""
    @objc dynamic var genuineTag: String? = ""
    
    override class func primaryKey() -> String {
        return "_id"
    }
}
