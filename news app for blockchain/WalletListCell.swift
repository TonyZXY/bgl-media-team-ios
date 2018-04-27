//
//  WalletListCell.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 19/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class WalletListCell: UITableViewCell {

    @IBOutlet weak var coinType: UILabel!
    @IBOutlet weak var coinNumber: UILabel!
    @IBOutlet weak var coinProfit: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    @IBOutlet weak var walletCell: UIView!
    @IBOutlet weak var upDownlogo: UIImageView!
    
    var color = ThemeColor()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //
        self.backgroundColor = color.themeColor()
        
        // set each cell view UI
        walletCell.layer.cornerRadius =  self.frame.height/4
        walletCell.backgroundColor = color.walletCellcolor()
        walletCell.layer.borderColor = UIColor.white.cgColor
        walletCell.layer.borderWidth = CGFloat((Float(1.0)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func checkRiseandfall(risefallnumber: String) {
        
        if risefallnumber.prefix(1) == "+" {
            //Profit with green
            coinProfit.textColor = color.riseColor()
            coinProfit.text = "▲ " + risefallnumber
        }else if risefallnumber.prefix(1) == "-" {
            // lost with red
           coinProfit.textColor = color.fallColor()
            coinProfit.text = "▼ " + risefallnumber
        } else{
            // Not any change with white
            coinProfit.textColor = UIColor.white
        }
    }

}
