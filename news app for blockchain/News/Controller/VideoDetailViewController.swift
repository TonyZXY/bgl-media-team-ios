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
    
    // set up contents
    var video: Video?{
        didSet{
            setupContent()
        }
    }
    
    // launch view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRootView()
        setupSubViews()
        setupContent()
        
        tabBarController?.tabBar.isHidden = true
        
    }
    
    func setupRootView(){
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    // constraints of the view
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
        
        
        scrollView.addConstraintsWithFormat(format: "V:|[v0(\(height))]-8-[v1(52)]-8-[v2(15)]-8-[v3(15)]-16-[v4]-16-|", views: videoplayer,titleLabel,timeLabel,authorLabel,descriptionLabel)
    }
    
    // set up content
    func setupContent(){
        let vurl = URL(string: (video?.url)!)
        videoplayer.loadVideoURL(vurl!)
        descriptionLabel.text = video?.videoDescription
        authorLabel.text = video?.author
        titleLabel.text = video?.title
        timeLabel.text = video?.publishedTime
    }
    
    let scrollView: UIScrollView = {
        let sc = UIScrollView()
        sc.backgroundColor = UIColor.darkGray
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    // YouTube Player
    let videoplayer: YouTubePlayerView = {
        let player = YouTubePlayerView()
        player.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
    
    let titleLabel: UILabel = {
        let lab = UILabel()
        lab.font = lab.font.withSize(20)
        lab.textColor = UIColor.white
        lab.numberOfLines = 2
        lab.textAlignment = .left
        return lab
    }()
    
    let timeLabel: UILabel = {
        let lab = UILabel()
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
        return lab
    }()
}
