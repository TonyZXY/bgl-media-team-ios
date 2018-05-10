//
//  VideoDetailViewController.swift
//  news app for blockchain
//
//  Created by Xuyang Zheng on 8/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import YouTubePlayer


class VideoDetailViewController: UIViewController {
    var video: Video?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRootView()
        setupSubViews()
        setupContent()
        
    }
    
    func setupRootView(){
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func setupSubViews(){
        scrollView.addSubview(videoplayer)
        let height = view.frame.width * 9 / 16
        scrollView.addConstraintsWithFormat(format: "H:|[v0(\(view.frame.width))]|", views: videoplayer)
        
        scrollView.addSubview(titleLabel)
        scrollView.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: titleLabel)
        scrollView.addSubview(timeLabel)
        scrollView.addConstraintsWithFormat(format: "H:|-16-[v0]", views: timeLabel)
        scrollView.addSubview(authorLabel)
        scrollView.addConstraintsWithFormat(format: "H:|-16-[v0]", views: authorLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: descriptionLabel)
        
        
        scrollView.addConstraintsWithFormat(format: "V:|-5-[v0(\(height))]-8-[v1(52)]-8-[v2(15)]-8-[v3(15)]-16-[v4]-10-|", views: videoplayer,titleLabel,timeLabel,authorLabel,descriptionLabel)
    }
    
    func setupContent(){
        //        videoplayer.loadVideoID("ljbhiEuGKSI")
        let urlString = "https://youtu.be/ljbhiEuGKSI"
        let url = URL(string: urlString)
        videoplayer.loadVideoURL(url!)
    }
    
    let scrollView: UIScrollView = {
        let sc = UIScrollView()
        sc.backgroundColor = UIColor.darkGray
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let videoplayer: YouTubePlayerView = {
        let player = YouTubePlayerView()
        //        player.backgroundColor = UIColor.black
        player.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
    
    let titleLabel: UILabel = {
        let lab = UILabel()
        lab.font = lab.font.withSize(20)
        lab.textColor = UIColor.white
        lab.text = "标题标题标题标题标题标题标题"
        lab.numberOfLines = 2
        lab.textAlignment = .left
        return lab
    }()
    
    let timeLabel: UILabel = {
        let lab = UILabel()
        lab.text = "Time TIme Time Time "
        lab.textColor = UIColor.white
        lab.font = lab.font.withSize(10)
        lab.numberOfLines = 1
        lab.textAlignment = .left
        return lab
    }()
    
    let authorLabel: UILabel = {
        let lab = UILabel()
        lab.font = lab.font.withSize(10)
        lab.textColor = UIColor.white
        lab.text = "author author author"
        lab.numberOfLines = 1
        lab.textAlignment = .left
        return lab
    }()
    
    let descriptionLabel: UILabel = {
        let lab = UILabel()
        lab.font = lab.font.withSize(16)
        lab.textColor = UIColor.white
        lab.numberOfLines = 0
        lab.textAlignment = .left
        lab.text = "内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容"
        return lab
    }()
}
