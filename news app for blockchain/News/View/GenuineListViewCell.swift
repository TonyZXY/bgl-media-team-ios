//
//  GeunineListViewCell.swift
//  news app for blockchain
//
//  Created by Xuyang Zheng on 8/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class GenuineListViewCell: BaseCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var position:Int = 0 {
        didSet{
            fetchData()
        }
    }// This int represent the position of Selection Bar -- Use to distingush VIDEO cell with NEWS CELL
    weak var homeViewController: HomeViewController?
    
    var videoDetailViewController: VideoDetailViewController = VideoDetailViewController()
    var genuineDetailViewController: GenuineDetailViewController = GenuineDetailViewController()
    
    var newsArrayList:[Genuine] = Array<Genuine>()
    var videoArrayList:[Video] = Array<Video>()
    
    let view:UIView = {
        let vi = UIView()
        return vi
    }()
    
    var selectionOtherTwo:[String] = ["原创文章","原创视频","币圈百科","实时分析"]
    
    lazy var selectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = ThemeColor().themeColor()
        layout.minimumInteritemSpacing = 2
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let line:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    lazy var cellListView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 5
        cv.backgroundColor = ThemeColor().themeColor()
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        position = 0
        setupRootView()
        setupSubViews()
        cellListView.register(GenuineCell.self, forCellWithReuseIdentifier: "genuineCell")
        cellListView.register(GenuineSliderViewCell.self, forCellWithReuseIdentifier: "sliderCell")
        selectionView.register(SelectionViewCell.self, forCellWithReuseIdentifier: "selectionCell")
        cellListView.register(VideoCell.self, forCellWithReuseIdentifier: "videoCell")
        selectionView.reloadData() // REVIEW: no need to call it here as it's loaded on start-Johnny Lin
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        selectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition:.left)
    }
    
    func setupRootView(){
        addSubview(view)
        addConstraintsWithFormat(format: "H:|[v0]|", views: view)
        addConstraintsWithFormat(format: "V:|[v0]|", views: view)
        view.backgroundColor = ThemeColor().themeColor()
    }
    
    func setupSubViews(){
        
        view.addSubview(line)
        view.addSubview(selectionView)
        view.addSubview(cellListView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: line)
        addConstraintsWithFormat(format: "H:|-5-[v0]|", views: selectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: cellListView)
        addConstraintsWithFormat(format: "V:|[v0(1)]-5-[v1(30)]", views: line,selectionView)
        
        
        
        cellListView.topAnchor.constraint(equalTo: selectionView.bottomAnchor).isActive = true
        cellListView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfItem: Int
        if collectionView == self.cellListView{
            if (position != 1){
            numberOfItem = newsArrayList.count + 1
            } else {
                numberOfItem = videoArrayList.count
            }
        }else{
            numberOfItem = 4
        }
        return numberOfItem
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(position != 1){
            if collectionView == self.cellListView{
                if indexPath.item == 0{
                    let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! GenuineSliderViewCell
                    cell3.homeViewController = self.homeViewController
                    if(newsArrayList.count != 0){
                        cell3.newsArrayList = Array(newsArrayList[0...2])
                    }
                    return cell3
                }else{
                    let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "genuineCell", for: indexPath) as! GenuineCell
                    if newsArrayList.count != 0 {
                        cell2.genuine = newsArrayList[indexPath.item-1]
                    }
                    return cell2
                }
            }else{
                let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "selectionCell", for: indexPath) as! SelectionViewCell
                cell1.textLabel.text = selectionOtherTwo[indexPath.item]
                return cell1
            }
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCell
            if videoArrayList.count != 0 {
                cell.video = videoArrayList[indexPath.item]
            }
            return cell
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size:CGSize
        if position == 1{
            if collectionView == self.cellListView {
                let height = (frame.width-30)*9/16 + 75
                size = CGSize(width: cellListView.frame.width, height: height)
            }else{
                size = CGSize(width: 70, height: selectionView.frame.height)
            }
        }else{
            if collectionView == self.cellListView {
                if indexPath.item == 0 {
                    size = CGSize(width: cellListView.frame.width, height: 150)
                }else{
                    size = CGSize(width: cellListView.frame.width, height: 110)
                }
            }else{
                size = CGSize(width: 70, height: selectionView.frame.height)
            }
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == selectionView){
            fetchData()
            position = indexPath.item
            cellListView.reloadData()
        }else{
            if(position==1){
                videoDetailViewController.video = videoArrayList[indexPath.item]
                homeViewController!.navigationController?.pushViewController(videoDetailViewController, animated: true)
            }else{
                if(indexPath.item != 0){
                    genuineDetailViewController.genuineContent = newsArrayList[indexPath.item - 1]
                    homeViewController?.navigationController?.pushViewController(genuineDetailViewController, animated: true)
                }
            }
        }
    }
    
    func fetchData() {
        if(position == 0){
            APIService.shardInstance.fetchGenuineContentTypeOne { (newsArrayList:[Genuine]) in
                self.newsArrayList = newsArrayList
                self.cellListView.reloadData()
            }
        }else if(position==1){
            APIService.shardInstance.fetchVideo { (videoArray:[Video]) in
                self.videoArrayList = videoArray
                self.cellListView.reloadData()
            }
        }else if(position==2){
            APIService.shardInstance.fetchGenuineContentTypeTwo { (newsArrayList:[Genuine]) in
                self.newsArrayList = newsArrayList
                self.cellListView.reloadData()
            }
        }else {
            APIService.shardInstance.fetchGenuineContentTypeThree { (newsArrayList:[Genuine]) in
                self.newsArrayList = newsArrayList
                self.cellListView.reloadData()
            }
        }
        
    }
    
}
