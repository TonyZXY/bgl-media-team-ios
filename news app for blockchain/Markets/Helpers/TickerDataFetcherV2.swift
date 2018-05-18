//
//  TickerDataFetcherV2.swift
//  news app for blockchain
//
//  Created by Sheng Li on 9/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

typealias CompletionHandler = (() -> Void)?

class TickerDataFetcherV2 {
    
    func getTickerData(starts: Int? = 1, completionHandler: CompletionHandler = nil) {
        let url = "https://api.coinmarketcap.com/v2/ticker/?convert=AUD&start=\(String(describing: starts!))"
        
        DispatchQueue.global(qos: .userInitiated).async {
            Alamofire.request(url, method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.JSONtoData(json: json)
                    self.updateAmountOfCoins(json: json)
                    DispatchQueue.main.async {
                        completionHandler?()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func JSONtoData(json: JSON) {
        let realm = try! Realm()
        realm.beginWrite()
        if let collection = json["data"].dictionary {
            for item in collection.values {
                let quotes = item["quotes"]["AUD"]
                let symbol = item["symbol"].string ?? "--"
                let name = item["name"].string ?? "--"
                let price = quotes["price"].double ?? 0.0
                let percent_change_1h = quotes["percent_change_1h"].double ?? 0.0
                let percent_change_24h = quotes["percent_change_24h"].double ?? 0.0
                let percent_change_7d = quotes["percent_change_7d"].double ?? 0.0
                let data = [symbol, name, price, percent_change_1h, percent_change_24h, percent_change_7d] as [Any]
                
                if realm.object(ofType: TickerDataRealm.self, forPrimaryKey: symbol) == nil {
                    realm.create(TickerDataRealm.self, value: data)
                } else {
                    realm.create(TickerDataRealm.self, value: data, update: true)
                }
            }
        }
        try! realm.commitWrite()
    }
    
    func updateAmountOfCoins(json: JSON) {
        // Store number of coins in coinmarketcap.
        let defaults = UserDefaults.standard
        let metadata = json["metadata"]["num_cryptocurrencies"]
        if metadata != JSON.null, let numberOfCryptocurrenciesInCMC = metadata.int
        {
            if let numberOfCoinsCurrent = defaults.object(forKey: "numberOfCryptocurrenciesInCMC") as? Int {
                if numberOfCoinsCurrent != numberOfCryptocurrenciesInCMC {
                    defaults.set(numberOfCryptocurrenciesInCMC, forKey: "numberOfCryptocurrenciesInCMC")
                    updateCoinDataInMarketsView()
                }
            } else {
                defaults.set(numberOfCryptocurrenciesInCMC, forKey: "numberOfCryptocurrenciesInCMC")
                updateCoinDataInMarketsView()
            }
        }
    }
    
    func updateCoinDataInMarketsView() {
        NotificationCenter.default.post(
            name: .updateCoinDataInMarketsView,
            object: UserDefaults.standard.object(forKey: "numberOfCryptocurrenciesInCMC"))
    }
    
    func getAllData(completionHandler: CompletionHandler = nil) {
        DispatchQueue.global(qos: .userInitiated).async {
            let defaults = UserDefaults.standard
            let numberOfCoinsCurrent = defaults.object(forKey: "numberOfCryptocurrenciesInCMC") as? Int ?? 100000
            let fetchTime = (numberOfCoinsCurrent + 100) / 100
            for hundreds in 0..<fetchTime {
                let starts = 1 + hundreds * 100
                self.getTickerData(starts: starts)
                if starts + 100 > numberOfCoinsCurrent {
                    break
                }
            }
            NotificationCenter.default.post(name: .updateCoinDataInMarketsView, object: nil)
        }
    }
    
    func getCoinList(completionHandler: CompletionHandler = nil) {
        let cryptoCompareClient = CryptoCompareClient()
        let container = try! Container()
        
        DispatchQueue.global(qos: .userInitiated).async {
            cryptoCompareClient.getCoinList(){result in
                switch result{
                case .success(let resultData):
                    guard let coinList = resultData?.Data else {return}
                    for (_, value) in coinList{
                        try! container.write { transaction in
                            transaction.add(value, update: true)
                        }
                    }
                    print("coinlist finished")
                    completionHandler?()
                case .failure(let error):
                    print("the error \(error.localizedDescription)")
                }
            }
        }
    }
}

extension Notification.Name {
    static let updateCoinDataInMarketsView = Notification.Name("updateCoinDataInMarketsView")
}
