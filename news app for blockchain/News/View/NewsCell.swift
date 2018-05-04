//
//  NewsCell.swift
//  NewsApp4
//
//  Created by Xuyang Zheng on 2/5/18.
//  Copyright © 2018 Xuyang Zheng. All rights reserved.
//

import UIKit

class NewsCell: BaseCell {
    
    let newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.blue
        return label
    }()
    
    let subtitleTextView: UILabel = {
        let textView = UILabel()
        textView.backgroundColor = UIColor.green
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let authorText: UILabel = {
        let text = UILabel()
        text.backgroundColor = UIColor.green
        text.font = UIFont.systemFont(ofSize: 10)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func setupViews(){
        addSubview(newsImage)
        addSubview(separatorView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        addSubview(authorText)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(138)]-8-[v1]-16-|",    views: newsImage,titleLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-[v1(1)]|",         views: newsImage,separatorView)
        addConstraintsWithFormat(format: "H:|[v0]|",                        views: separatorView)
        addConstraintsWithFormat(format: "V:|-16-[v0]",                     views: titleLabel)
        
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: newsImage, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        addConstraint(NSLayoutConstraint(item: authorText, attribute: .top, relatedBy: .equal, toItem: subtitleTextView, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: authorText, attribute: .right, relatedBy: .equal, toItem: subtitleTextView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: authorText, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .width, multiplier: 0, constant: 40))
        addConstraint(NSLayoutConstraint(item: authorText, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 10))
    }
    
}
