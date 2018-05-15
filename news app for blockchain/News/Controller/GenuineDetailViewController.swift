//
//  GenuineDetailViewController.swift
//  news app for blockchain
//
//  Created by Xuyang Zheng on 9/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class GenuineDetailViewController: UIViewController {
    
    var genuineContent:Genuine?{
        didSet{
            setupContent()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRootView()
        setupSubViews()
        setupContent()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupContent(){
        titleView.text = genuineContent?.title
        newsImageView.setImage(urlString: (genuineContent?.imageURL)!)
        // REVIEW: should use time string it self, something like (genuineContent?.publishedTime)!.formattedString() -Johnny Lin
//        timeLabel.text =
        timeLabel.text = genuineContent?.publishedTime
        authorLabel.text = genuineContent?.author
        textView.text = genuineContent?.detail
    }
    
    lazy var rootView:UIScrollView = {
        let vi = UIScrollView()
        vi.backgroundColor = ThemeColor().themeColor()
        return vi
    }()
    
    let titleView: UILabel = {
        let tv = UILabel()
        tv.font = tv.font.withSize(20)
        tv.numberOfLines = 0
        tv.textColor = UIColor.white
        tv.textAlignment = .left
        
        return tv
    }()
    
    let newsImageView: UIImageView = {
        let im = UIImageView()
        im.contentMode = .scaleAspectFill
        return im
    }()
    
    let timeLabel: UILabel = {
        let tv = UILabel()
        tv.font = tv.font.withSize(10)
        tv.textAlignment = .left
        tv.textColor = UIColor.white
        return tv
    }()
    
    let authorLabel: UILabel = {
        let tv = UILabel()
        tv.textColor = UIColor.white
        tv.textAlignment = .left
        tv.font = tv.font.withSize(10)
        return tv
    }()
    
    let textView:UILabel = {
        let tv = UILabel()
        tv.font = tv.font.withSize(16)
        tv.textColor = UIColor.white
        tv.numberOfLines = 0
        return tv
    }()
    
    let imageContainer: UIView = {
        let iv = UIView()
        iv.clipsToBounds = true
        return iv
    }()
    
    func setupRootView(){
        view.addSubview(rootView)
        rootView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        rootView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        rootView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        rootView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupSubViews(){
        rootView.addSubview(titleView)
        rootView.addSubview(timeLabel)
        rootView.addSubview(authorLabel)
        rootView.addSubview(imageContainer)
        imageContainer.addSubview(newsImageView)
        rootView.addSubview(textView)
        rootView.addConstraintsWithFormat(format: "H:|[v0]|", views: newsImageView)
        rootView.addConstraintsWithFormat(format: "V:|[v0]", views: newsImageView)
        rootView.addConstraintsWithFormat(format: "H:|-16-[v0]-30-|", views: titleView)
        rootView.addConstraintsWithFormat(format: "H:|-16-[v0]", views: timeLabel)
        rootView.addConstraintsWithFormat(format: "H:|-16-[v0]", views: authorLabel)
        rootView.addConstraintsWithFormat(format: "H:|-16-[v0(\(view.frame.width - 32))]-16-|", views: imageContainer)
        rootView.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: textView)
        rootView.addConstraintsWithFormat(format: "V:|-16-[v0(52)]-8-[v1(15)]-8-[v2(15)]-16-[v3(250)]-16-[v4]-16-|", views: titleView,timeLabel,authorLabel,imageContainer,textView)
        
    }
}