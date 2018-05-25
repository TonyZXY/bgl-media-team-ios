//
//  SetDataResult.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 10/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SetDataResult{
    
    func writeJsonExchange(){
        Alamofire.request("https://min-api.cryptocompare.com/data/all/exchanges", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentsURL.appendingPathComponent("Exchanges.json")
                let json = JSON(value)
                do {
                    let rawData = try json.rawData()
                    try rawData.write(to: fileURL, options: .atomic)
                } catch {
                    print("Error \(error)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
