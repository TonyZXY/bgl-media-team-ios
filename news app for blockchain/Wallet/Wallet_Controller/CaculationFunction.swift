//
//  CaculationFunction.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 14/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation

class CaculationFunction{
    let cryptoCompareClient = CryptoCompareClient()
    
    func getCurrencyNumber(coinName:String,tradingPairsName:String,exchangName:String,amount:Int,transactionPrice:Double)->CaculateResult{
        var price:Double = 0
        let results = CaculateResult()
        cryptoCompareClient.getTradePrice(from: coinName, to: tradingPairsName, exchange: exchangName){ result in
            switch result{
            case .success(let resultData):
                for(_, value) in resultData!{
                    price = value
                }
                results.single = Double(price)
                results.total = Double(price) * Double(amount)
                results.profit = results.total - transactionPrice
                print(results.single)
            case .failure(let error):
                print("the error \(error.localizedDescription)")
            }
        }
        return results
    }
}
