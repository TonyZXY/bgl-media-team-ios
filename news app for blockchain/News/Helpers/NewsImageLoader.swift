//
//  NewsImageLoader.swift
//  news app for blockchain
//
//  Created by Xuyang Zheng on 14/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

func loadImage(imageView: UIImageView, urlString: String) {
    let url = URL(string: urlString)
    imageView.kf.setImage(with: url)
}
