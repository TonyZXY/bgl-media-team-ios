//
//  Video.swift
//  news app for blockchain
//
//  Created by Xuyang Zheng on 9/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift

struct Video: Decodable {
    var _id: String?
    var title: String?
    var videoDescription: String?
    var imageURL: String?
    var url: String?
    var publishedTime: String?
    var author: String?
    var localeTag: String?
    var typeTag: String?
}
