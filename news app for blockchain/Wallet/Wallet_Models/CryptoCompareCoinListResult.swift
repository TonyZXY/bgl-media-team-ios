//
//  CoinList.swift
//  ApiWrapperTest
//
//  Created by yanshi on 23/4/18.
//  Copyright © 2018 yan. All rights reserved.
//

import Foundation

struct  CryptoCompareCoinListResult: Decodable {
    let Data: [String:CryptoCompareCoin]
    let Response: String?
    let Message: String?
}
