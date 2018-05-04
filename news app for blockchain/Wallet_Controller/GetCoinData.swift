//
//  GetCoinData.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 4/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation

class GetCoinData{
    let cryptoCompareClient = CryptoCompareClient()
    var ss:String = ""
    
    func getExchangeList()->Void{
        cryptoCompareClient.getExchangeList(){ result in
            switch result{
            case .success(let resultData):
//                print(resultData?.AllExchanges["BTCMarkets"]?.TradingPairs["BTC"] ?? "")
                guard let exchangePairs = resultData?.AllExchanges else {return}
                for(exc, pairs) in exchangePairs{
                    print(exc)
                }
            case .failure(let error):
                print("the error \(error.localizedDescription)")
            }
        }
    }

}


