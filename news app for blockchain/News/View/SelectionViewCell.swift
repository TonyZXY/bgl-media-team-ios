//
//  SelectionViewCell.swift
//  NewsApp4
//
//  Created by Xuyang Zheng on 3/5/18.
//  Copyright © 2018 Xuyang Zheng. All rights reserved.
//

import UIKit

class SelectionViewCell: BaseCell {
    override func setupViews() {
        super.setupViews()
        setupRootView()
        
    }
    
    lazy var view: UIView = {
        var view = UIView()
        return view
    }()
    
    
    func setupRootView(){
        addSubview(view)
        addConstraintsWithFormat(format: "H:|[v0]|", views: view)
        addConstraintsWithFormat(format: "V:|[v0]|", views: view)
        view.backgroundColor = UIColor.blue
        view.addSubview(textLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: textLabel)
        addConstraintsWithFormat(format: "V:|-3-[v0]-3-|", views: textLabel)
    }
    
    lazy var textLabel: UILabel = {
        var tx = UILabel()
        tx.backgroundColor = .darkGray
        tx.textColor = UIColor.white
        tx.textAlignment = .center
        tx.font = tx.font.withSize(13)
        return tx
    }()
}
