//
//  News.swift
//  NewsApp2
//
//  Created by Xuyang Zheng on 27/4/18.
//  Copyright © 2018 Xuyang Zheng. All rights reserved.
//

import UIKit
import RealmSwift

struct News: Decodable {
    let _id: String?
    let title: String?
    let newsDescription: String?
    let imageURL: String?
    let detail: String?
    let publishedTime: String?
    let author: String?
    let localeTag: String?
    let contentTag: String?
}
