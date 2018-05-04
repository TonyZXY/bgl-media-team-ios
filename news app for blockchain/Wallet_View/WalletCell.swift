//
//  WalletListsCell.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 4/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class WalletCell:UICollectionViewCell{
    var color = ThemeColor()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView(){
        addSubview(coinImage)
        addSubview(coinName)
        addSubview(profitChange)
        addSubview(coinAmount)
        addSubview(coinTotalPrice)
        addSubview(coinSinglePrice)
        
        self.backgroundColor = color.walletCellcolor()
        
        //CoinImage
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views:
            ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views:
            ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: coinImage, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        
        //CoinName
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-5-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: coinName, attribute: .bottom, relatedBy: .equal, toItem: coinImage, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        //ProfitChange
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v2]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: profitChange, attribute: .centerY, relatedBy: .equal, toItem: coinName, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        //CoinAmount
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-5-[v3]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: coinAmount, attribute: .top, relatedBy: .equal, toItem: coinImage, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        //CoinTotalPrice
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v3]-5-[v4]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: coinTotalPrice, attribute: .centerY, relatedBy: .equal, toItem: coinAmount, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        //CoinTotalPrice
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v5]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: coinSinglePrice, attribute: .centerY, relatedBy: .equal, toItem: coinAmount, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        
    }
    
    let coinImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "navigation_arrow.png"))
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var coinName:UILabel = {
        var label = UILabel()
        label.text = "Bitcoin"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var profitChange:UILabel = {
        var label = UILabel()
        label.text = "-16.3%"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var coinAmount:UILabel = {
        var label = UILabel()
        label.text = "10BTC"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var coinTotalPrice:UILabel = {
        var label = UILabel()
        label.text = "($1,2678)"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var coinSinglePrice:UILabel = {
        var label = UILabel()
        label.text = "12,6780"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func checkRiseandfall(risefallnumber: String) {
        
        if risefallnumber.prefix(1) == "+" {
            //Profit with green
            profitChange.textColor = color.riseColor()
            profitChange.text = "▲ " + risefallnumber
        }else if risefallnumber.prefix(1) == "-" {
            // lost with red
            profitChange.textColor = color.fallColor()
            profitChange.text = "▼ " + risefallnumber
        } else{
            // Not any change with white
            profitChange.textColor = UIColor.white
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init Error")
    }
}

