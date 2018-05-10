//
//  News.swift
//  NewsApp2
//
//  Created by Xuyang Zheng on 27/4/18.
//  Copyright © 2018 Xuyang Zheng. All rights reserved.
//

import UIKit
import RealmSwift

class News: Decodable {
    var _id: String?
    var title: String?
    var newsDescription: String?
    var imageURL: String?
    var detail: String?
    var publishedTime: String?
    var author: String?
    var localeTag: String?
    var contentTag: String?
}