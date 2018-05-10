//
//  ViewController.swift
//  NewsApp4
//
//  Created by Xuyang Zheng on 2/5/18.
//  Copyright © 2018 Xuyang Zheng. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
//    let titleLab:[String] = ["新闻","原创"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.darkGray
        navigationController?.navigationBar.backgroundColor = UIColor.darkGray
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationItem
//        navigationController?.hidesBarsOnSwipe = true
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: view.frame.height))
        titleLabel.text = "新闻"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView.backgroundColor = UIColor.white
        setupView()
        
//        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(ListViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.alwaysBounceHorizontal = false
//        DispatchQueue.main.async {
//            self.collectionView.reloadData()
//        }
        
//        let index = IndexPath(row: 1, section: 0)
//        let cell: ListViewCell = collectionView.cellForItem(at: index) as! ListViewCell
//        print(cell.option)
    }
    
    lazy var menuBar: NewsMenuBar = {
        let mb = NewsMenuBar()
        mb.homeController = self
        return mb
    }()
    

    lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    func setupView(){
        let colorView = UIView()
        colorView.backgroundColor = UIColor.darkGray
        view.addSubview(colorView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: colorView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: colorView)
        
        
        view.addSubview(menuBar)
        view.addSubview(collectionView)
//        view.addConstraintsWithFormat(format: "H:[v0]", views: collectionView)
        view.addConstraintsWithFormat(format: "V:[v0(40)]-0-[v1]|", views: menuBar,collectionView)
//        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)

        menuBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        menuBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
//
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / collectionView.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListViewCell
//        cell.option = titleLab[indexPath.item]
//        print(titleLab[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: 110)
//    }
//
    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    

}



