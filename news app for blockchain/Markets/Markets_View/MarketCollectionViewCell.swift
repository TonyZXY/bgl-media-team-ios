//
//  MarketCollectionViewCell.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 4/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

class MarketCollectionViewCell:UICollectionViewCell{
    var color = ThemeColor()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    var priceChange: Double?
    
    var object: TickerDataRealm? {
        didSet {
            var roundedPrice = object?.price ?? 0.0
            roundedPrice = round(roundedPrice * 100) / 100
            coinLabel.text = object?.symbol
            coinNumber.text = "AUD $" + "\(roundedPrice)"
            coinChange.text = "\(priceChange ?? 0.0)"
            guard let percentChange = priceChange else { return }
            if percentChange > 0.0 {
                coinChange.textColor = .green
            } else if percentChange == 0.0 {
                coinChange.textColor = .white
            } else {
                coinChange.textColor = .red
            }
            changeCoinIcon()
        }
    }
    
    let coinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
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
    
    func setupView(){
        backgroundColor = color.walletCellcolor()
        
        addSubview(coinImage)
        addSubview(coinLabel)
        addSubview(coinChange)
        addSubview(coinType)
        addSubview(coinNumber)
        
        //coinImage
        self.layer.cornerRadius = self.frame.height / 4
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[v0(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinLabel,"v3":coinChange,"v4":coinType,"v5":coinNumber]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinLabel,"v3":coinChange,"v4":coinType,"v5":coinNumber]))
        NSLayoutConstraint(item: coinImage, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        
        //coinLabel
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-5-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinLabel,"v2":coinChange,"v3":coinType,"v4":coinNumber]))
        NSLayoutConstraint(item: coinLabel, attribute: .bottom, relatedBy: NSLayoutRelation.equal, toItem: coinImage, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        
        //coinType
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-5-[v3]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinLabel,"v2":coinChange,"v3":coinType,"v4":coinNumber]))
        NSLayoutConstraint(item: coinType, attribute: .top, relatedBy: NSLayoutRelation.equal, toItem: coinImage, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        
        //coinChange
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v2]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinLabel,"v2":coinChange,"v3":coinType,"v4":coinNumber]))
        NSLayoutConstraint(item: coinChange, attribute:.centerY , relatedBy: NSLayoutRelation.equal, toItem: coinLabel, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        
        //coinNunmber
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v4]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinLabel,"v2":coinChange,"v3":coinType,"v4":coinNumber]))
        NSLayoutConstraint(item: coinNumber, attribute:.centerY , relatedBy: NSLayoutRelation.equal, toItem: coinType, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init Error")
    }
    
    func changeCoinIcon() {
//        coinImage = UIImageView()
//        coinImage.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        coinImage.clipsToBounds = true
//        coinImage.contentMode = UIViewContentMode.scaleAspectFit
//        coinImage.translatesAutoresizingMaskIntoConstraints = false
        
        coinImage.image = nil
        
        coinImage.subviews.forEach({ $0.removeFromSuperview() })
        
        let icon: UIButton = {
            let button = UIButton()
            button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            button.layer.cornerRadius = 25
            button.backgroundColor = #colorLiteral(red: 0.2, green: 0.2039215686, blue: 0.2235294118, alpha: 1)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(object!.symbol, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = button.titleLabel?.font.withSize(20)
            button.titleLabel?.numberOfLines = 1
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleEdgeInsets.left = 0
            button.titleEdgeInsets.right = 0
            button.titleEdgeInsets.top = 0
            button.titleEdgeInsets.bottom = 0
            return button
        }()
        coinImage.addSubview(icon)
        
        var constraints = [NSLayoutConstraint]()
        
        let centerXConstraints = NSLayoutConstraint(item: icon, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: coinImage, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0)
        
        let centerYConstraints = NSLayoutConstraint(item: icon, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: coinImage, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
        
        let widthContraints =  NSLayoutConstraint(item: icon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        let heightContraints = NSLayoutConstraint(item: icon, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        
        constraints.append(centerXConstraints)
        constraints.append(centerYConstraints)
        constraints.append(widthContraints)
        constraints.append(heightContraints)
        
        NSLayoutConstraint.activate(constraints)
        
        let realm = try! Realm()
        let result = realm.objects(CryptoCompareCoinsRealm.self).filter("Name = %@", object!.symbol)
        if result.count == 1 {
//            icon.removeFromSuperview()
            let coin = result[0]
            let url = URL(string: "https://www.cryptocompare.com" + coin.ImageUrl)
            coinImage.kf.setImage(with: url, completionHandler: {
                (image, error, cacheType, imageUrl) in
                icon.removeFromSuperview()
                // image: Image? `nil` means failed
                // error: NSError? non-`nil` means failed
                // cacheType: CacheType
                //                  .none - Just downloaded
                //                  .memory - Got from memory cache
                //                  .disk - Got from disk cache
                // imageUrl: URL of the image
                })
        }
    }
}
