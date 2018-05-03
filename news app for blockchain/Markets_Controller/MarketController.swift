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
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)
//        let color:[UIColor] = [.blue,.gray]
        
//        if indexPath.item == 1 {
//            
//            return collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
//        }
//        cell.backgroundColor = color[indexPath.item]
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
//        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = color.themeColor()
        setupMenuBar()
        setupColleectionView()
        let titleLabel = UILabel()
        titleLabel.text = "Blockchain Global"
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
//        collectionviews.index
        // Do any additional setup after loading the view.
    }

    lazy var menuBar: MenuBar = {
       let mb = MenuBar()
        mb.marketController = self
//       mb.translatesAutoresizingMaskIntoConstraints = false
       return mb
    }()
    
    lazy var collectionviews: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout:layout)
//        collectionview.backgroundColor = UIColor.red
        collectionview.isPagingEnabled = true
        collectionview.delegate = self
        collectionview.dataSource = self
        return collectionview
        
//        let layout = UICollectionViewFlowLayout()
//        let collectionview = UICollectionView(frame: .zero, collectionViewLayout:layout)
//        if let flowlayout = collectionview.collectionViewLayout as? UICollectionViewFlowLayout{
//            flowlayout.scrollDirection = .horizontal
//        }
    }()
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
//        return cell
//    }
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        
//        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":menuBar])
//        )
//        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":menuBar])
//        )
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":menuBar]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":menuBar]))
    }

    private func setupColleectionView(){
        view.addSubview(collectionviews)
        collectionviews.register(MarketsCell.self, forCellWithReuseIdentifier: "Markets")
        collectionviews.register(Watchlist.self, forCellWithReuseIdentifier: "Watchlists")
//        collectionviews.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
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


