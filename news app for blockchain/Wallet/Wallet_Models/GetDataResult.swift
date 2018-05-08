//
//  GetDataResult.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 8/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation

class GetDataResult{
    typealias tradingCoin = [String]
    typealias chooseCoin = [String:tradingCoin]
    typealias exchangeChoose = [String:chooseCoin]
    
    func getExchangeList()->exchangeChoose{
        var jsonData = exchangeChoose()
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsURL.appendingPathComponent("Exchanges.json").path
        if FileManager.default.fileExists(atPath: filePath), let data = FileManager.default.contents(atPath: filePath) {
            do{
                let json = try JSONDecoder().decode(exchangeChoose.self, from: data)
                jsonData = json as exchangeChoose
            } catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
        }
        return jsonData
    }
    
    func getTradingCoinList(market:String,coin:String)->tradingCoin{
        var jsonData = tradingCoin()
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsURL.appendingPathComponent("Exchanges.json").path
        if FileManager.default.fileExists(atPath: filePath), let data = FileManager.default.contents(atPath: filePath) {
            do{
                let json = try JSONDecoder().decode(exchangeChoose.self, from: data)
                var coinTradingPairs = json[market]?[coin]
                if coinTradingPairs != nil{
                    jsonData = coinTradingPairs!
                }
            } catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
        }
        return jsonData
    }
}


