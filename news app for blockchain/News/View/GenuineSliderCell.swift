//
//  GenuineSliderCell.swift
//  news app for blockchain
//
//  Created by Xuyang Zheng on 9/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class GenuineSliderCell: BaseCell {
    
    var newsContent: Genuine? {
        didSet{
            textView.text = newsContent?.title
            if (newsContent != nil){
                image.setImage(urlString: (newsContent?.imageURL)!)
            }
        }
    }
    
    override func setupViews() {
        super.setupViews()
        setupRootView()
        setupSubViews()
        backgroundColor = ThemeColor().themeColor()
    }
    
    let view: UIView = {
        let vi = UIView()
        vi.backgroundColor = ThemeColor().walletCellcolor()
        vi.layer.cornerRadius = 4
        vi.layer.masksToBounds = true
        return vi
    }()
    
    func setupRootView(){
        addSubview(view)
        addConstraintsWithFormat(format: "H:|-3-[v0]-3-|", views: view)
        addConstraintsWithFormat(format: "V:|-2-[v0]-2-|", views: view)
    }
    
    let image:UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let textView:UILabel = {
        let tv = UILabel()
        tv.backgroundColor = UIColor(white: 0.2, alpha: 0.8)
        tv.textColor = UIColor.white
        return tv
    }()
    
    func setupSubViews(){
        view.addSubview(image)
        addConstraintsWithFormat(format: "H:|-3-[v0]-3-|", views: image)
        addConstraintsWithFormat(format: "V:|-3-[v0]-3-|", views: image)
        image.addSubview(textView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: textView)
        addConstraintsWithFormat(format: "V:|-100-[v0]|", views: textView)
    }
    
    
}

