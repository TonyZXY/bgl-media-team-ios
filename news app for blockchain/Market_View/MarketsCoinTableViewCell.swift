//
//  MarketsCoinListTableView.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 1/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class MarketsCoinTableViewCell:UITableViewCell{
    var color = ThemeColor()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init has not been completed")
    }
    
    let coinImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "navigation_arrow.png"))
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let coinLabel: UILabel = {
        let label = UILabel()
        label.text = "Bitcoin"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let coinChange:UILabel = {
        let label = UILabel()
        label.text = "-4.98%"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let coinType: UILabel = {
        let label = UILabel()
        label.text = "全球市场平均价"
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let coinNumber: UILabel = {
        let label = UILabel()
        label.text = "$11345"
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupviews(){
        addSubview(coinImage)
        addSubview(coinLabel)
        addSubview(coinChange)
        addSubview(coinType)
        addSubview(coinNumber)
        
        self.layer.cornerRadius = self.frame.height / 4
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinLabel,"v3":coinChange,"v4":coinType,"v5":coinNumber]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[v0(50)]-30-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinLabel,"v3":coinChange,"v4":coinType,"v5":coinNumber]))
        let myLabelverticalConstraint = NSLayoutConstraint(item: coinImage, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([myLabelverticalConstraint])
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-5-[v1]-[v2]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinLabel,"v2":coinChange,"v3":coinType,"v4":coinNumber]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinLabel,"v2":coinChange,"v3":coinType,"v4":coinNumber]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[v2]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinLabel,"v2":coinChange,"v3":coinType,"v4":coinNumber]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-5-[v3]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinLabel,"v2":coinChange,"v3":coinType,"v4":coinNumber]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1]-5-[v3]-30-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinLabel,"v2":coinChange,"v3":coinType,"v4":coinNumber]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v3]-[v4]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinLabel,"v2":coinChange,"v3":coinType,"v4":coinNumber]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v2]-5-[v4]-30-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinLabel,"v2":coinChange,"v3":coinType,"v4":coinNumber]))
    }
    
    
    func checkRiseandfall(risefallnumber: String) {
        if risefallnumber.prefix(1) == "+" {
            //Profit with green
            coinChange.textColor = color.riseColor()
            coinChange.text = "▲ " + risefallnumber
        }else if risefallnumber.prefix(1) == "-" {
            // lost with red
            coinChange.textColor = color.fallColor()
            coinChange.text = "▼ " + risefallnumber
        } else{
            // Not any change with white
            coinChange.textColor = UIColor.white
        }
    }
}
