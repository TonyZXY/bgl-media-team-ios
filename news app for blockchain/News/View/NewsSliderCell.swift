//
//  SliderCell.swift
//  NewsApp4
//
//  Created by Xuyang Zheng on 3/5/18.
//  Copyright © 2018 Xuyang Zheng. All rights reserved.
//

import UIKit

class NewsSliderCell: BaseCell {
    
    var newsContent: News? {
        didSet{
            textView.text = newsContent?.title
            if(newsContent != nil){
                image.image = ImageLoader.instance.loadImage(imageURL: (newsContent?.imageURL)!)
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
        tv.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
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
