//
//  GeneralView.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 21/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import Foundation
import UIKit

class GeneralView:UIView{
    override init (frame : CGRect) {
        super.init(frame : frame)
        setUpView()
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    
    func setUpStackView(view:[UIView],spacing:CGFloat,axis:UILayoutConstraintAxis)-> UIStackView{
        let stackView = UIStackView(arrangedSubviews: view)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = .fillEqually
        return stackView
    }
    
    func setUpView(){
        addSubview(scrollView)
        scrollView.addSubview(FirstView)
        scrollView.addSubview(SecondView)
        scrollView.addSubview(ImageView)
        scrollView.addSubview(LastView)
        
        FirstView.addSubview(spinner)
        FirstView.addSubview(totalNumber)
        FirstView.addSubview(totalRiseFall)
        
        SecondView.addSubview(market)
        SecondView.addSubview(tradingPairs)
        SecondView.addSubview(edit)
        

        
        let stack2 = setUpStackView(view: [setUpStackView(view: [volume,volumeResult], spacing: 0, axis: .vertical),setUpStackView(view: [circulatingSupply,circulatingSupplyResult], spacing: 0, axis: .vertical)], spacing: 5, axis: .horizontal)
        
        let totalStack = setUpStackView(view: [setUpStackView(view: [marketCap,marketCapResult], spacing: 0, axis: .vertical),stack2], spacing: 5, axis: .vertical)

        
        LastView.addSubview(totalStack)
        LastView.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: totalStack)
        LastView.addConstraintsWithFormat(format: "V:|[v0]|", views: totalStack)
        
        //ScrollView Constraint
        addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        
        //Frist View constraint
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: FirstView)
        scrollView.addConstraintsWithFormat(format: "V:|-10-[v0(80)]", views: FirstView)
        NSLayoutConstraint(item: FirstView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0).isActive = true
        
        //Second View constraint
        scrollView.addConstraintsWithFormat(format: "H:|[v1]|", views: FirstView,SecondView)
        scrollView.addConstraintsWithFormat(format: "V:[v0]-10-[v1(50)]", views: FirstView,SecondView)
        NSLayoutConstraint(item: SecondView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0).isActive = true
        
        //Image View constraint
        
        scrollView.addConstraintsWithFormat(format: "H:|[v1]|", views: SecondView,ImageView)
        scrollView.addConstraintsWithFormat(format: "V:[v0]-10-[v1(200)]", views: SecondView,ImageView)
        NSLayoutConstraint(item: ImageView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0).isActive = true
        print(ImageView.frame.size.width)
        print(ImageView.frame.size.height)
        print()
        
        //Last View constraint
        scrollView.addConstraintsWithFormat(format: "H:|[v1]|", views: ImageView,LastView)
        scrollView.addConstraintsWithFormat(format: "V:[v0]-10-[v1(120)]|", views: ImageView,LastView)
        NSLayoutConstraint(item: LastView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0).isActive = true
        
        //First View TotalNumebr Label Constraint
        NSLayoutConstraint(item: totalNumber, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: FirstView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: totalNumber, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: FirstView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: totalNumber, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: FirstView, attribute: NSLayoutAttribute.height, multiplier: 1/2, constant: 0).isActive = true
        
        
        //First View TotalRiseFall Label Constraint
        NSLayoutConstraint(item: totalRiseFall, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: FirstView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: totalRiseFall, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: FirstView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: totalRiseFall, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: FirstView, attribute: NSLayoutAttribute.height, multiplier: 1/2, constant: 0).isActive = true
        
        //First View Spinnner
        NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: FirstView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: spinner, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: FirstView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: -15).isActive = true
        
        //Second View market Label Constraint
        NSLayoutConstraint(item: market, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: SecondView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint(item: market, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: SecondView, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: -5).isActive = true
        NSLayoutConstraint(item: market, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: SecondView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: market, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: SecondView, attribute: NSLayoutAttribute.height, multiplier: 1/2, constant: 0).isActive = true
        
        //Second View tradingPairs Label Constraint
        NSLayoutConstraint(item: tradingPairs, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: SecondView, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: -5).isActive = true
        NSLayoutConstraint(item: tradingPairs, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: SecondView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: tradingPairs, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: SecondView, attribute: NSLayoutAttribute.height, multiplier: 1/2, constant: 0).isActive = true
        NSLayoutConstraint(item: tradingPairs, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: market, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 5).isActive = true
        
        //Second View edit button Constraint
        NSLayoutConstraint(item: edit, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: SecondView, attribute: NSLayoutAttribute.width, multiplier: 1/3, constant: -5).isActive = true
        NSLayoutConstraint(item: edit, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: SecondView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: edit, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: SecondView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: edit, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: SecondView, attribute: NSLayoutAttribute.height, multiplier: 1/2, constant: 0).isActive = true
        NSLayoutConstraint(item: edit, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: tradingPairs, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 5).isActive = true
        
        
    }
    
    var mainView:UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var scrollView:UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.backgroundColor = ThemeColor().themeColor()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var FirstView:UIView = {
        var view = UIView()
        view.backgroundColor = ThemeColor().walletCellcolor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var SecondView:UIView = {
        var view = UIView()
        view.backgroundColor = ThemeColor().walletCellcolor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var ImageView:UIView = {
        var imageView = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size.height = 200
//        imageView.frame.size.width = 300
        imageView.backgroundColor = .orange
        return imageView
    }()
    
    var LastView:UIView = {
        var view = UIView()
        view.backgroundColor = ThemeColor().walletCellcolor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var totalNumber:UILabel = {
        var label = UILabel()
        label.textColor = UIColor.white
        label.text = "0"
        label.font = label.font.withSize(30)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var totalRiseFall:UILabel = {
        var label = UILabel()
        label.text = "0"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var market:UILabel = {
        var label = UILabel()
        label.text = "0"
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 0.8
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tradingPairs:UILabel = {
        var label = UILabel()
        label.text = "0"
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 0.8
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var edit:UIButton = {
        var button = UIButton(type:.system)
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var marketCap:UILabel = {
        var label = UILabel()
        label.text = "Market Cap"
        label.font = label.font.withSize(15)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var marketCapResult:UILabel = {
        var label = UILabel()
        label.text = "0"
        label.font = label.font.withSize(15)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var marketRiseFall:UILabel = {
        var label = UILabel()
        label.text = "0"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var marketRiseFallResult:UILabel = {
        var label = UILabel()
        label.text = "0"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var volume:UILabel = {
        var label = UILabel()
        label.text = "Volume(24h)"
        label.font = label.font.withSize(15)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var spinner:UIActivityIndicatorView = {
        var spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    var volumeResult:UILabel = {
        var label = UILabel()
        label.text = "0"
        label.font = label.font.withSize(15)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var circulatingSupply:UILabel = {
        var label = UILabel()
        label.text = "Circulating Supply"
        label.font = label.font.withSize(15)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var circulatingSupplyResult:UILabel = {
        var label = UILabel()
        label.text = "0"
        label.font = label.font.withSize(15)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var low:UILabel = {
        var label = UILabel()
        label.text = "0"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var lowResult:UILabel = {
        var label = UILabel()
        label.text = "0"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var high:UILabel = {
        var label = UILabel()
        label.text = "0"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var highResult:UILabel = {
        var label = UILabel()
        label.text = "0"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}



