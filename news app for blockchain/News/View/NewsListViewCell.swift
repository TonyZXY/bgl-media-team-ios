//
//  ListViewCell.swift
//  NewsApp4
//
//  Created by Xuyang Zheng on 3/5/18.
//  Copyright © 2018 Xuyang Zheng. All rights reserved.
//

import UIKit

class NewsListViewCell: BaseCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var position:Int = 0 {
        didSet{
            fetchData()
        }
    }
    
    weak var homeViewController: HomeViewController?
    
    let newsViewController: NewsDetailViewController = NewsDetailViewController()
    
    var newsArrayList:[News] = Array<News>()
    
    let view: UIView = {
        let vi = UIView()
        return vi
    }()
    
    var selectionOptionOne:[String] = ["国内","国际","深度","趋势"]
    
    lazy var selectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = ThemeColor().themeColor()
        layout.minimumInteritemSpacing = 2
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let line: UIView = {
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
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        
        return refreshControl
    }()
    
    override func setupViews() {
        super.setupViews()
        fetchData()
        setupRootView()
        setupSubViews()
        // REVIEW: put in a separate method - registerCells -Johnny Lin
        cellListView.register(NewsCell.self, forCellWithReuseIdentifier: "newsCell")
        cellListView.register(NewsSliderViewCell.self, forCellWithReuseIdentifier: "sliderCell")
        selectionView.register(SelectionViewCell.self, forCellWithReuseIdentifier: "selectionCell")
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
        cellListView.addSubview(self.refresher)
        
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
            numberOfItem = newsArrayList.count + 1
        }else{
            numberOfItem = 4
        }
        return numberOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.cellListView{
            if indexPath.item == 0{
                let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! NewsSliderViewCell
                cell3.homeViewController = self.homeViewController
                if(newsArrayList.count != 0){
                    // implemented data load
                    cell3.newsArrayList = Array(newsArrayList[0...2])
                }
                
                return cell3
            }else{
                let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCell
                cell2.news = newsArrayList[indexPath.item - 1]
                return cell2
            }
        }else{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "selectionCell", for: indexPath) as! SelectionViewCell
            cell1.textLabel.text = selectionOptionOne[indexPath.item]
            return cell1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size:CGSize
        if collectionView == self.cellListView{
            if indexPath.item == 0 {
                size = CGSize(width: cellListView.frame.width, height: 150)
            }else{
                size = CGSize(width: cellListView.frame.width, height: 110)
            }
        }else{
            size = CGSize(width: 70, height: selectionView.frame.height)
        }
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == selectionView){
            position = indexPath.item
        }else{
            if(indexPath.item != 0){
            newsViewController.newsContent = newsArrayList[indexPath.item-1]
            homeViewController!.navigationController?.pushViewController(newsViewController, animated: true)
            }
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        fetchData()
        print("start refreshing")
        self.refresher.endRefreshing()
    }
    
    func fetchData() {
        if(position == 0){
            APIService.shardInstance.fetchLocalNews { (newsArrayList:[News]) in
                self.newsArrayList = newsArrayList
                self.cellListView.reloadData()
            }
        }else if(position == 1){
            APIService.shardInstance.fetchInternationalNews { (newsArrayList:[News]) in
                self.newsArrayList = newsArrayList
                self.cellListView.reloadData()
            }
        }else if (position == 2){
            APIService.shardInstance.fetchNewsContentTypeOne { (newsArrayList:[News]) in
                self.newsArrayList = newsArrayList
                self.cellListView.reloadData()
            }
        }else{
            APIService.shardInstance.fetchNewsContentTypeTwo { (newsArrayList:[News]) in
                self.newsArrayList = newsArrayList
                self.cellListView.reloadData()
            }
        }
    }
    
    
}

