//
//  MarketsTotalView.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 30/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class MarketsTotalView:UICollectionViewCell{
    var color = ThemeColor()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = color.walletCellcolor()
        setupView()
    }
    
    //市场总资产
    let totalFunds:UILabel={
        var totalfunds = UILabel()
        totalfunds.text = "市场总资产"
        totalfunds.sizeToFit()
        totalfunds.textColor = UIColor.white
        return totalfunds
    }()
    
    let number:UILabel={
        var number = UILabel()
        number.text = "AUD123"
        number.textColor = UIColor.white
        return number
    }()
    
    let change:UILabel={
        var change = UILabel()
        change.text = "1%"
        change.sizeToFit()
        change.textColor = UIColor.white
        return change
    }()
    
    func setupView(){
        addSubview(totalFunds)
        addSubview(number)
        addSubview(change)
        
        totalFunds.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-10-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":totalFunds,"v1":number]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":totalFunds]))
        addConstraint(NSLayoutConstraint(item: totalFunds, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        number.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":number]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":number]))
        addConstraint(NSLayoutConstraint(item: number, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: number, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        change.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1]-10-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":change,"v1":number]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":change]))
        addConstraint(NSLayoutConstraint(item: change, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
