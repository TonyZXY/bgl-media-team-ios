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
    
    var string = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRootView()
        setupSubViews()
        setupContent()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func setupContent(){
        titleView.text = genuineContent?.title
        newsImageView.setImage(urlString: (genuineContent?.imageURL)!)
        timeLabel.text = String().timeFormatter(timeString: (genuineContent?.publishedTime)!)
        authorLabel.text = genuineContent?.author
        textView.text = genuineContent?.detail
    }
    
    lazy var rootView:UIScrollView = {
        let vi = UIScrollView()
        vi.backgroundColor = ThemeColor().themeColor()
        //        vi.backgroundColor = UIColor.green
        return vi
    }()
    
    let titleView: UILabel = {
        let tv = UILabel()
        //        tv.backgroundColor = UIColor.blue
        tv.font = tv.font.withSize(20)
        tv.numberOfLines = 0
        tv.textColor = UIColor.white
        tv.textAlignment = .left
        
        return tv
    }()
    
    let newsImageView: UIImageView = {
        let im = UIImageView()
//        im.backgroundColor = UIColor.blue
        return im
    }()
    
    let timeLabel: UILabel = {
        let tv = UILabel()
        //        tv.backgroundColor = UIColor.blue
        tv.font = tv.font.withSize(10)
        tv.textAlignment = .left
        tv.textColor = UIColor.white
        return tv
    }()
    
    let authorLabel: UILabel = {
        let tv = UILabel()
        //        tv.backgroundColor = UIColor.blue
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
    
    func setupRootView(){
        view.addSubview(rootView)
        //        print(view.frame.width)
        //        rootView.contentSize = CGSize(width: view.frame.width, height: 4000)
        //        view.addConstraintsWithFormat(format: "H:|[v0]|", views: rootView)
        //        view.addConstraintsWithFormat(format: "V:|[v0]|", views: rootView)
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
        rootView.addSubview(newsImageView)
        rootView.addSubview(textView)
        rootView.addConstraintsWithFormat(format: "H:|-16-[v0]-30-|", views: titleView)
        rootView.addConstraintsWithFormat(format: "H:|-16-[v0]", views: timeLabel)
        rootView.addConstraintsWithFormat(format: "H:|-16-[v0]", views: authorLabel)
        rootView.addConstraintsWithFormat(format: "H:|-16-[v0(\(view.frame.width - 32))]-16-|", views: newsImageView)
        rootView.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: textView)
        rootView.addConstraintsWithFormat(format: "V:|-16-[v0(52)]-8-[v1(15)]-8-[v2(15)]-16-[v3(250)]-16-[v4]|", views: titleView,timeLabel,authorLabel,newsImageView,textView)
        
    }
}
