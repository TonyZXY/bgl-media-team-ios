//
//  GetDataResult.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 8/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

struct Currency:Decodable{
    var query:[String:Int]
    var results:[String:CurrencyPairs]
}

struct CurrencyPairs:Decodable{
    var id:String?
    var fr:String?
    var to:String?
    var val:Double?
}

struct GlobalCoinList:Decodable{
    var id:Int?
    var name:String?
    var symbol:String?
    var website_slug:String?
}

struct MetaData:Decodable{
    var timestamp:Int?
    var num_cryptocurrencies:Int?
    var error:String?
}

struct MarketCapData:Decodable {
    var data:[GlobalCoinList]?
    var metadata:MetaData?
}

class GetDataResult{
    let cryptoCompareClient = CryptoCompareClient()
    let container = try! Container()
    typealias tradingCoin = [String]
    typealias chooseCoin = [String:tradingCoin]
    typealias exchangeChoose = [String:chooseCoin]
//    typealias globalCoinList = ["String":[GlobalCoinList]]
    
//    let cc:[String:[AnyObject]] = ["data":[GlobalCoinList]]
    
    func getCoinList(){
        cryptoCompareClient.getCoinList(){result in
            switch result{
            case .success(let resultData):
                guard let coinList = resultData?.Data else {return}
                for (_,value) in coinList{
                    try! self.container.write { transaction in
                        transaction.add(value, update: true)
                    }
                }
            case .failure(let error):
                print("the error \(error.localizedDescription)")
            }
        }
    }
    
    
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
    
    func getMarketCapCoinList()->[GlobalCoinList]{
        var jsonData = [GlobalCoinList]()
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsURL.appendingPathComponent("CoinList.json").path
        if FileManager.default.fileExists(atPath: filePath), let data = FileManager.default.contents(atPath: filePath) {
            do{
                let json = try JSONDecoder().decode(MarketCapData.self, from: data)
                jsonData = (json.data)!
            } catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
        }
        return jsonData
    }
    
    func getMarketCapCoinDetail(coinId:Int,priceType:String,completion:@escaping (GlobalMarket?)->Void){
        let baseUrl:String = "https://api.coinmarketcap.com/v2/ticker/"
        let urlString:String = baseUrl + String(coinId) + "/?convert=" + priceType
        Alamofire.request(urlString).responseJSON { (response) in
            let json = try! JSONDecoder().decode(MarketAllData.self, from: response.data!)
            if json.data != nil{
                let globalMarket:GlobalMarket = GlobalMarket(market: json, priceType: priceType)
                completion(globalMarket)
            } else{
                completion(nil)
            }
        }
    }
            
    func getTradingCoinList(market:String,coin:String)->tradingCoin{
        var jsonData = tradingCoin()
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsURL.appendingPathComponent("Exchanges.json").path
        if FileManager.default.fileExists(atPath: filePath), let data = FileManager.default.contents(atPath: filePath) {
            do{
                let json = try JSONDecoder().decode(exchangeChoose.self, from: data)
                let coinTradingPairs = json[market]?[coin]
                if coinTradingPairs != nil{
                    jsonData = coinTradingPairs!
                }
            } catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
        }
       
        return jsonData
    }
    
    typealias StringCompletion = (_ success: Bool, _ Double: Double) -> Void
    
    func getCurrencyApi(from:String,to:String,price:Double,completion: @escaping StringCompletion){
        var transferPrice:Double = 0
        let baseUrl = "https://free.currencyconverterapi.com/api/v5/convert?q="
        let currencyPairs = from + "_" + to
        let urlString = baseUrl + currencyPairs
        
        guard let url = URL(string: urlString) else { return }
        let transferPrices = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSONDecoder().decode(Currency.self, from: data)
                if json.query["count"] != 0 && json.query["count"] != nil{
                    let currency = Double((json.results[currencyPairs]?.val)!)
                    transferPrice = currency * price
                    completion(true,transferPrice)
                }
            } catch let jsonErr{
                print("Error serializing json:",jsonErr)
                completion(false,transferPrice)
            }
        }
        transferPrices.resume()
    }
    
    
    func getCryptoCurrencyApi(from:String,to:String,price:Double,completion: @escaping StringCompletion){
        var transferPrice:Double = 0
        let baseUrl = "https://min-api.cryptocompare.com/data/price?"
        let currencyPairs = "fsym="+from + "&" + "tsyms=" + to
        let urlString = baseUrl + currencyPairs
        
        let queue = DispatchQueue(label: "ssss")
        
        queue.sync {
            guard let url = URL(string: urlString) else { return }
            let transferPrices = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let json = try JSONDecoder().decode([String:Double].self, from: data)
                    for n in json{
                        transferPrice = Double(n.value) * price
                    }
                    completion(true,transferPrice)
                } catch let jsonErr{
                    print("Error serializing json:",jsonErr)
                    completion(false,transferPrice)
                }
            }
            transferPrices.resume()
        }
    }
    
    typealias StringCompletion1 = (_ success: Bool, _ double: Double, _ double:Double) -> Void
    
    func getCryptoCurrencyApis(from:String,toAUD:String,toUSD:String,price:Double,completion: @escaping StringCompletion1){
        
        var transferAUDs:Double = 0
        var transferUSDs:Double = 0
        let baseUrl = "https://min-api.cryptocompare.com/data/price?"
        let currencyAUD = "fsym="+from + "&" + "tsyms=" + toAUD
        let currencyUSD = "fsym="+from + "&" + "tsyms=" + toAUD
        let urlString1 = baseUrl + currencyAUD
        let urlString2 = baseUrl + currencyUSD
        
        let queue = DispatchQueue(label: "sss")
        
        queue.sync {
            guard let url1 = URL(string: urlString1) else { return }
            let transferAUD = URLSession.shared.dataTask(with: url1) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let json = try JSONDecoder().decode([String:Double].self, from: data)
                    for n in json{
                        transferAUDs = Double(n.value) * price
                    }
                } catch let jsonErr{
                    print("Error serializing json:",jsonErr)
                }
            }
            transferAUD.resume()
        }
        
        queue.sync {
            guard let url2 = URL(string: urlString2) else { return }
            let transferUSD = URLSession.shared.dataTask(with: url2) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let json = try JSONDecoder().decode([String:Double].self, from: data)
                    for n in json{
                        transferUSDs = Double(n.value) * price
                    }
                } catch let jsonErr{
                    print("Error serializing json:",jsonErr)
                    
                }
            }
            transferUSD.resume()
        }
        
        queue.sync {
            completion(true,transferAUDs,transferUSDs)
        }
    }
    
    
}


