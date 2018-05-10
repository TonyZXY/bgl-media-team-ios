//
//  GenuineCell.swift
//  news app for blockchain
//
//  Created by Xuyang Zheng on 9/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class GenuineCell: BaseCell {
    weak var homeViewController: HomeViewController!
    
    var genuine:Genuine? {
        didSet{
            titleLabel.text = genuine?.title
            newsImage.image = ImageLoader.instance.loadImage(imageURL: "http://www.randwick.nsw.gov.au/__data/assets/image/0007/14875/Latest-News.jpg")
            subtitleTextView.text = genuine?.genuineDescription
            authorText.text = genuine?.author
        }
    }
    
    let view:UIView = {
        let view = UIView()
        return view
    }()
    
    let newsImage: UIImageView = {
        let imageView = UIImageView()
//        imageView.backgroundColor = UIColor.blue
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.textColor = UIColor.white
//        label.backgroundColor = UIColor.blue
        return label
    }()
    
    let subtitleTextView: UILabel = {
        let textView = UILabel()
//        textView.backgroundColor = UIColor.green
        textView.textColor = UIColor.lightGray
        textView.font = textView.font.withSize(12)
        textView.numberOfLines = 2
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let authorText: UILabel = {
        let text = UILabel()
//        text.backgroundColor = UIColor.green
        text.textColor = UIColor.lightGray
        text.font = UIFont.systemFont(ofSize: 10)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func setupViews(){
        addSubview(view)
        // REVIEW: in a separate method -Johnny Lin
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: view)
        addConstraintsWithFormat(format: "V:|-1-[v0]-1-|", views: view)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.addSubview(newsImage)
        view.addSubview(titleLabel)
        view.addSubview(subtitleTextView)
        view.addSubview(authorText)
        view.backgroundColor = ThemeColor().walletCellcolor()
        addConstraintsWithFormat(format: "H:|-16-[v0(135)]-8-[v1]-16-|",    views: newsImage,titleLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|",                views: newsImage)
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
