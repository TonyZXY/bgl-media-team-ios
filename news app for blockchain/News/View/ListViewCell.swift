//
//  ListViewCell.swift
//  NewsApp4
//
//  Created by Xuyang Zheng on 3/5/18.
//  Copyright © 2018 Xuyang Zheng. All rights reserved.
//

import UIKit

class ListViewCell: BaseCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    let view: UIView = {
        let vi = UIView()
        return vi
    }()
    
    var selectionOptionOne:[String] = ["国内","国际","深度","趋势"]
    var selectionOtherTwo:[String] = ["原创文章","原创视频","币圈百科","实时分析"]
    
    
    lazy var selectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 2
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
//    lazy var sliderView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = UIColor.brown
//        layout.scrollDirection = .horizontal
//        cv.isPagingEnabled = true
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        cv.dataSource = self
//        cv.delegate = self
//        return cv
//    }()
    
    lazy var cellListView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.orange
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
//    lazy var scrollView: UIScrollView = {
//        let sv = UIScrollView(frame: .zero)
//        sv.contentSize.height = 2000
//        sv.contentSize.width = frame.width
//        sv.backgroundColor = UIColor.blue
//        sv.isScrollEnabled = true
//        return sv
//    }()
    
//    var sliderLayoutConstrain: NSLayoutConstraint!
    
    override func setupViews() {
        super.setupViews()
        setupRootView()
        setupSubViews()
        cellListView.register(NewsCell.self, forCellWithReuseIdentifier: "newsCell")
        cellListView.register(SliderViewCell.self, forCellWithReuseIdentifier: "sliderCell")
        selectionView.register(SelectionViewCell.self, forCellWithReuseIdentifier: "selectionCell")
        selectionView.reloadData()
    }
    
    func setupRootView(){
        addSubview(view)
        addConstraintsWithFormat(format: "H:|[v0]|", views: view)
        addConstraintsWithFormat(format: "V:|[v0]|", views: view)
        view.backgroundColor = .green
    }
    
    func setupSubViews(){
       
        view.addSubview(selectionView)
//        view.addSubview(scrollView)
//        view.addSubview(sliderView)
        view.addSubview(cellListView)
        
        
//        addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: selectionView)
//        addConstraintsWithFormat(format: "H:|[v0]|", views: sliderView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: cellListView)
        
//        addConstraintsWithFormat(format: "V:|[v0(35)]-0-[v1(150)]-0-[v2]|", views: selectionView,sliderView,cellListView)
        addConstraintsWithFormat(format: "V:|[v0(35)]", views: selectionView)
        
//        addConstraint(NSLayoutConstraint(item: sliderView, attribute: .top, relatedBy: .equal, toItem: selectionView, attribute: .bottom, multiplier: 1, constant: 0))
//
//        sliderLayoutConstrain = NSLayoutConstraint(item: sliderView, attribute: .bottom, relatedBy: .equal, toItem: selectionView, attribute: .bottom, multiplier: 1, constant: 150)
//        addConstraint(sliderLayoutConstrain)
        
        
        
        cellListView.topAnchor.constraint(equalTo: selectionView.bottomAnchor).isActive = true
        cellListView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        scrollView.addSubview(sliderView)
//        scrollView.addSubview(cellListView)
//        addConstraint(NSLayoutConstraint(item: sliderView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: sliderView, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: sliderView, attribute: .right, relatedBy: .equal, toItem: scrollView, attribute: .right, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: sliderView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 0, constant: 150))
//
//        addConstraint(NSLayoutConstraint(item: cellListView, attribute: .top, relatedBy: .equal, toItem: sliderView, attribute: .bottom, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: cellListView, attribute: .left, relatedBy: .equal, toItem: scrollView, attribute: .left, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: cellListView, attribute: .right, relatedBy: .equal, toItem: scrollView, attribute: .right, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: cellListView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1, constant: 0))
//        addConstraintsWithFormat(format: "V:|[v0(150)]-0-[v1]|", views: sliderView,cellListView)
//        sliderView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
//        sliderView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
//        sliderView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
//        sliderView.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: 150).isActive = true
//
//        cellListView.topAnchor.constraint(equalTo: sliderView.bottomAnchor).isActive = true
//        cellListView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
//        cellListView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
//        cellListView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == self.cellListView{
//            sliderView.isHidden = true
//            cellListView.topAnchor.constraint(equalTo: selectionView.bottomAnchor).isActive = true
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfSection: Int
        if collectionView == self.cellListView{
            numberOfSection = 10
//        }else if collectionView == self.sliderView {
//            numberOfSection = 3
        }else{
            numberOfSection = 4
        }
        return numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:UICollectionViewCell
        if collectionView == self.cellListView{
            if indexPath.item == 0{
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath)
            }else{
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath)
            }
        }else{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "selectionCell", for: indexPath) as! SelectionViewCell
            cell1.textLabel.text = selectionOptionOne[indexPath.item]
            return cell1
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size:CGSize
        if collectionView == self.cellListView{
            if indexPath.item == 0 {
                size = CGSize(width: cellListView.frame.width, height: 150)
            }else{
            size = CGSize(width: cellListView.frame.width, height: 110)
            }
//        }else if collectionView == self.sliderView {
//            size = CGSize(width: sliderView.frame.width, height: sliderView.frame.height)
        }else{
            size = CGSize(width: 70, height: selectionView.frame.height)
        }
        return size
    }
    
    //this section detect and control scroll up and down
//    private var lastContentOffset: CGFloat = 0
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == cellListView {
//            if (self.lastContentOffset > scrollView.contentOffset.y) {
//                // move up
//            }
//            else if (self.lastContentOffset < scrollView.contentOffset.y) {
//                // move down
//            }
//            
//            // update the new position acquired
//            self.lastContentOffset = scrollView.contentOffset.y
//        }
//    }
    
    
    
}
