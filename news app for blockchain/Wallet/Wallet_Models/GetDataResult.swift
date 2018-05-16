//
//  GetDataResult.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 8/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation

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
    
    typealias StringCompletion = (_ success: Bool, _ float: Float) -> Void
    
    func getCurrencyApi(from:String,to:String,price:Float,completion: @escaping StringCompletion){
        var transferPrice:Float = 0
        let baseUrl = "https://free.currencyconverterapi.com/api/v5/convert?q="
        let currencyPairs = from + "_" + to
        let urlString = baseUrl + currencyPairs
        
        guard let url = URL(string: urlString) else { return }
        let transferPrices = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do{
                let json = try JSONDecoder().decode(Currency.self, from: data)
                if json.query["count"] != 0 && json.query["count"] != nil{
                    let currency = Float((json.results[currencyPairs]?.val)!)
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
    
    
    func getCryptoCurrencyApi(from:String,to:String,price:Float,completion: @escaping StringCompletion){
        var transferPrice:Float = 0
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
                        transferPrice = Float(n.value) * price
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
    
    typealias StringCompletion1 = (_ success: Bool, _ float: Float, _ float2:Float) -> Void
    
    func getCryptoCurrencyApis(from:String,toAUD:String,toUSD:String,price:Float,completion: @escaping StringCompletion1){
        
        var transferAUDs:Float = 0
        var transferUSDs:Float = 0
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
                        transferAUDs = Float(n.value) * price
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
                        transferUSDs = Float(n.value) * price
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


