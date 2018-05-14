//
//  Genuine.swift
//  news app for blockchain
//
//  Created by Xuyang Zheng on 9/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift

class Genuine :  Decodable {
    var _id: String?
    var title: String?
    var genuineDescription: String?
    var imageURL: String?
    var detail: String?
    var publishedTime: String?
    var author: String?
    var genuineTag: String?
    
}
