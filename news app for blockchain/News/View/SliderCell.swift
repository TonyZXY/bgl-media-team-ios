//
//  SliderCell.swift
//  NewsApp4
//
//  Created by Xuyang Zheng on 3/5/18.
//  Copyright © 2018 Xuyang Zheng. All rights reserved.
//

import UIKit

class SliderCell: BaseCell {
    override func setupViews() {
        super.setupViews()
        setupRootView()
        setupSubViews()
        backgroundColor = UIColor.green
    }
    
    let view: UIView = {
        let vi = UIView()
        return vi
    }()
    
    func setupRootView(){
        addSubview(view)
        addConstraintsWithFormat(format: "H:|[v0]|", views: view)
        addConstraintsWithFormat(format: "V:|[v0]|", views: view)
    }
    
    let image:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.blue
        return iv
    }()
    
    let textView:UILabel = {
        let tv = UILabel()
        tv.backgroundColor = UIColor.yellow
        return tv
    }()
    
    func setupSubViews(){
        view.addSubview(image)
        addConstraintsWithFormat(format: "H:|-3-[v0]-3-|", views: image)
        addConstraintsWithFormat(format: "V:|-3-[v0]-3-|", views: image)
        image.addSubview(textView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: textView)
        addConstraintsWithFormat(format: "V:|-120-[v0]|", views: textView)
    }
    
    
}
