//
//  NewsFlash.swift
//  news app for blockchain
//
//  Created by Sheng Li on 27/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation
import RealmSwift

class NewsFlash: Object {
    @objc dynamic var dateTime = ""
    @objc dynamic var contents = ""
}
