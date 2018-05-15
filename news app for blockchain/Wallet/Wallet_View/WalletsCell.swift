//
//  WalletsCell.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 4/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class WalletsCell:UITableViewCell{
    var color = ThemeColor()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    func setupView(){
        addSubview(walletView)
        walletView.addSubview(coinImage)
        walletView.addSubview(coinName)
        walletView.addSubview(profitChange)
        walletView.addSubview(coinAmount)
        walletView.addSubview(coinTotalPrice)
        walletView.addSubview(coinSinglePrice)
        
        self.backgroundColor = color.themeColor()
        
        //Wallet View
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[v0]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views:
            ["v0":walletView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0(80)]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views:
            ["v0":walletView]))
        NSLayoutConstraint(item: walletView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: walletView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0).isActive = true
        
        //CoinImage
        walletView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views:
            ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        walletView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views:
            ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: coinImage, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: walletView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        
        //CoinName
        walletView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-5-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: coinName, attribute: .bottom, relatedBy: .equal, toItem: coinImage, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        //ProfitChange
        walletView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v2]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: profitChange, attribute: .centerY, relatedBy: .equal, toItem: coinName, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        //CoinAmount
        walletView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-5-[v3]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: coinAmount, attribute: .top, relatedBy: .equal, toItem: coinImage, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        //CoinTotalPrice
        walletView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v3]-5-[v4]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: coinTotalPrice, attribute: .centerY, relatedBy: .equal, toItem: coinAmount, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        //CoinTotalPrice
        walletView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v5]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: coinSinglePrice, attribute: .centerY, relatedBy: .equal, toItem: coinAmount, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        
    }
    
    let walletView:UIView = {
        var view = UIView()
        view.backgroundColor = ThemeColor().walletCellcolor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        if risefallnumber.prefix(1) == "-" {
            // lost with red
            profitChange.textColor = color.fallColor()
            profitChange.text = "▼ " + risefallnumber + "%"
        } else if risefallnumber == "0.00"{
            // Not any change with white
            profitChange.text = "--"
            profitChange.textColor = UIColor.white
        } else {
            //Profit with green
            profitChange.textColor = color.riseColor()
            profitChange.text = "▲ " + "+" + risefallnumber + "%"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init Error")
    }
}
