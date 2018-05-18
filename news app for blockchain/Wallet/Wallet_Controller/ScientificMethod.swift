//
//  ScientificMethod.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 17/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func caculateScientificMethod(number:Double)->String{
        var value:String = ""
        var getNumber:String =  String(number)
        
        if getNumber.prefix(1) != "-" {
            getNumber = "+" + getNumber
        }
        
        if getNumber[getNumber.index(getNumber.startIndex, offsetBy: 2)] == "."{
            value = String(format:"%.8f",number)
        } else{
            value = String(format:"%.2f",number)
        }
        return value
    }
}
