//
//  ChangeRiseFallColor.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 25/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
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
}
