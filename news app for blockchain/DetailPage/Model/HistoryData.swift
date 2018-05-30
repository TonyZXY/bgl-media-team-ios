//
//  HistoryData.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 28/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation

protocol HistoryData:class{
    func setPrice(name:String)
    func setChange(abbName:String)
    func getExchangeName()->String
    func getCoinName()->String
    
}
