//
//  FetchData.swift
//  DetailCandleStickChart
//
//  Created by Sheng Li on 18/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation

typealias CompletionHandler = (() -> Void)?

class HistoricalDataFetcher {
    var historicalDataStruct: HistoricalDataStruct?
    
    var limit: Int {
        return Params.amountOfCandlesDisplayed * Params.interval * Params.multipleData
    }
    
    // intervel should be:
    // histoday, histohour, histominute
    func fetcher(coinSymbol: String, currency: String = "AUD", completionHandler: CompletionHandler = nil) {
        let url = URL(string: "https://min-api.cryptocompare.com/data/\(Params.intervalParam)?fsym=\(coinSymbol)&tsym=\(currency)&limit=\(limit)")
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self?.historicalDataStruct = HistoricalDataStruct(json: data)
                completionHandler?()
            }
        }
    }
}
