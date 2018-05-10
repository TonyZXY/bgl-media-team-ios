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

class TickerDataFetcherV2 {
    typealias CompletionHandler = (_ success:Bool) -> Void
    
    func getTickerData(start: Int, completionHandler: @escaping CompletionHandler) {
        //        let realm = try! Realm()
        let url = "https://api.coinmarketcap.com/v2/ticker/?start=\(start)&limit=10&convert=AUD"
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.JSONtoData(json: json["data"])
                DispatchQueue.main.async {
                    //                    self.cleanOldNewsFlash()
                    //                    self.results = try! Realm().objects(NewsFlash.self).sorted(byKeyPath: "dateTime", ascending: false)
                    //                    self.tableView.reloadData()
                }
                completionHandler(true)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func JSONtoData(json: JSON) {
        let realm = try! Realm()
        realm.beginWrite()
        if let collection = json.dictionary {
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
}
