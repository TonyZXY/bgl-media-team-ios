//
//  SliderViewCell.swift
//  NewsApp4
//
//  Created by Xuyang Zheng on 3/5/18.
//  Copyright © 2018 Xuyang Zheng. All rights reserved.
//

import UIKit

class SliderViewCell: BaseCell ,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    override func setupViews() {
        super.setupViews()
        setupRootView()
    }
    
    lazy var rootView:UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var sliderView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.brown
        layout.scrollDirection = .horizontal
        cv.isPagingEnabled = true
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        cv.dataSource = self
        cv.delegate = self
        cv.bounces = false
        cv.alwaysBounceHorizontal = false
        cv.register(SliderCell.self, forCellWithReuseIdentifier: "Slider")
        return cv
    }()
    
    func setupRootView(){
        addSubview(rootView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: rootView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: rootView)
        rootView.backgroundColor = .yellow
        backgroundColor = UIColor.green
        
        rootView.addSubview(sliderView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: sliderView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: sliderView)
        
//        rootView.addSubview(image)
//        addConstraintsWithFormat(format: "H:|-3-[v0]-3-|", views: image)
//        addConstraintsWithFormat(format: "V:|-3-[v0]-3-|", views: image)
//        image.addSubview(textLabel)
//        addConstraintsWithFormat(format: "H:|[v0]|", views: textLabel)
//        addConstraintsWithFormat(format: "V:|-100-[v0]|", views: textLabel)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Slider", for: indexPath)
        return cell
    }
    
}
