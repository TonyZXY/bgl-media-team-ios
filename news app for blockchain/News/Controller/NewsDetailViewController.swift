//
//  ViewController.swift
//  NewsPage
//
//  Created by Xuyang Zheng on 4/5/18.
//  Copyright © 2018 Xuyang Zheng. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    var newsContent:News?{
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
//        print(newsContent?.title)
        //to be setup content here
        titleView.text = newsContent?.title
//        newsImageView.image = ??
        timeLabel.text = newsContent?.publishedTime
        timeLabel.text = String().formatDate(date: (newsContent?.publishedTime)!)
        authorLabel.text = newsContent?.author
        textView.text = newsContent?.detail
        newsImageView.image = ImageLoader.instance.loadImage(imageURL: (newsContent?.imageURL)!)
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
        tv.text = "新闻标题新闻标题新闻标题新闻标题新闻标题新闻标题新闻标题"
        tv.font = tv.font.withSize(20)
        tv.numberOfLines = 0
        tv.textColor = UIColor.white
        tv.textAlignment = .left
        
        return tv
    }()
    
    let newsImageView: UIImageView = {
        let im = UIImageView()
        im.backgroundColor = UIColor.blue
        return im
    }()
    
    let timeLabel: UILabel = {
        let tv = UILabel()
        //        tv.backgroundColor = UIColor.blue
        tv.text = "time time time time time"
        tv.font = tv.font.withSize(10)
        tv.textAlignment = .left
        tv.textColor = UIColor.white
        return tv
    }()
    
    let authorLabel: UILabel = {
        let tv = UILabel()
        //        tv.backgroundColor = UIColor.blue
        tv.text = "Author Author Author"
        tv.textColor = UIColor.white
        tv.textAlignment = .left
        tv.font = tv.font.withSize(10)
        return tv
    }()
    
    let textView:UILabel = {
        let tv = UILabel()
        tv.text = "内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容"
        
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
