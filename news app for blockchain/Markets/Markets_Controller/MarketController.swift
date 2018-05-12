//
//  MarketController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 29/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class MarketController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var color = ThemeColor()
    var menuitems = ["Markets","Watchlists"]
    
    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionviews.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuitems[indexPath.row], for: indexPath)
        
        if indexPath.row == 1 {
            if let watchListCell = cell as? WatchList {
                watchListCell.removeWatchInMarketsCellDelegate = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? MarketsCell
                if let marketsCell = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? MarketsCell {
                    marketsCell.updateWatchInWatchListDelegate = watchListCell
                }
                return watchListCell
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x/2
    }
    
    func  scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexpath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexpath as IndexPath, animated: true, scrollPosition:[])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = color.themeColor()
        setupMenuBar()
        setupColleectionView()
        let titleLabel = UILabel()
        titleLabel.text = "Blockchain Global"
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.marketController = self
        return mb
    }()
    
    lazy var collectionviews: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout:layout)
        collectionview.isPagingEnabled = true
        collectionview.delegate = self
        collectionview.dataSource = self
        return collectionview
    }()
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":menuBar]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":menuBar]))
    }
    
    private func setupColleectionView(){
        view.addSubview(collectionviews)
        collectionviews.register(MarketsCell.self, forCellWithReuseIdentifier: "Markets")
        collectionviews.register(WatchList.self, forCellWithReuseIdentifier: "Watchlists")
        collectionviews.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":collectionviews,"v1":menuBar]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1]-0-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":collectionviews,"v1":menuBar]))
        collectionviews.backgroundColor = color.themeColor()
    }
    
    class market:UICollectionViewCell{
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        let view:UIView = {
            var view = UIView()
            return view
        }()
        
        func setupView(){
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class watchlist:UICollectionViewCell{
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = UIColor.yellow
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}


