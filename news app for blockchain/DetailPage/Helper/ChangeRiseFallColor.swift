//
//  ChangeRiseFallColor.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 25/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func ChangeRiseFallColor(risefallnumber: String)->UILabel{
        let result = UILabel()
        if risefallnumber.prefix(1) == "-" {
            // lost with red
            result.textColor = ThemeColor().fallColor()
            result.text = "▼ " + risefallnumber
        } else if Double(risefallnumber) == 0.0{
            // Not any change with white
            result.text = "--"
            result.textColor = UIColor.white
        } else {
            //Profit with green
            result.textColor = ThemeColor().riseColor()
            result.text = "▲ " + "+" + risefallnumber
        }
        return result
    }
    
    func checkDataRiseFallColor(risefallnumber: Double,label:UILabel,type:String) {
        if String(risefallnumber).prefix(1) == "-" {
            // lost with red
            label.textColor = ThemeColor().fallColor()
            if type == "Percent"{
                label.text = "(" + scientificMethod(number: risefallnumber) + "%" + ")"
            } else{
                label.text = "▼ " + "A$" + scientificMethod(number: risefallnumber)
            }
        } else if String(risefallnumber) == "0.0"{
            // Not any change with white
            label.text = "--"
            label.textColor = UIColor.white
        } else {
            //Profit with green
            label.textColor = ThemeColor().riseColor()
            if type == "Percent"{
                label.text =  "(" +  scientificMethod(number: risefallnumber) + "%" + ")"
            } else{
                  label.text = "▲ " + "A$" + scientificMethod(number: risefallnumber)
            }
        }
    }
}
