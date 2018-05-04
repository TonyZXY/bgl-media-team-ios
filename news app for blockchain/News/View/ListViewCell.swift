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
    
    let homeView: HomeViewController = HomeViewController()
    
    
    let newsViewController: NewsDetailViewController = NewsDetailViewController()
    
    
    let First:[String] = ["1","2","3","4","5","6","7","8","9","10"]
    let second:[String] = ["a","b","c","d","e","f","g","h","i","j","k"]
    
    var data:[String] = []
    
    lazy var selectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = ThemeColor().themeColor()
        layout.minimumInteritemSpacing = 2
        cv.dataSource = self
        cv.delegate = self
        return cv
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
        setupRootView()
        setupSubViews()
        cellListView.register(NewsCell.self, forCellWithReuseIdentifier: "newsCell")
        cellListView.register(SliderViewCell.self, forCellWithReuseIdentifier: "sliderCell")
        selectionView.register(SelectionViewCell.self, forCellWithReuseIdentifier: "selectionCell")
        selectionView.reloadData()
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        selectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition:.left)
        data = fetchData(d: 0)
    }
    
    func setupRootView(){
        addSubview(view)
        addConstraintsWithFormat(format: "H:|[v0]|", views: view)
        addConstraintsWithFormat(format: "V:|[v0]|", views: view)
        view.backgroundColor = ThemeColor().themeColor()
    }
    
    func setupSubViews(){
       
        view.addSubview(selectionView)
        view.addSubview(cellListView)
        
        addConstraintsWithFormat(format: "H:|-5-[v0]|", views: selectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: cellListView)
        addConstraintsWithFormat(format: "V:|-5-[v0(30)]", views: selectionView)
        
        
        
        cellListView.topAnchor.constraint(equalTo: selectionView.bottomAnchor).isActive = true
        cellListView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfSection: Int
        if collectionView == self.cellListView{
            numberOfSection = 10
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
                let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCell
                let navigationController: UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myNavigationController") as! UINavigationController
                cell2.homeViewController = navigationController.childViewControllers.first as! HomeViewController
                cell2.titleLabel.text = data[indexPath.item-1]
                return cell2
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
        }else{
            size = CGSize(width: 70, height: selectionView.frame.height)
        }
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == selectionView){
            data = fetchData(d: indexPath.item)
            print(data)
            print(indexPath.item)
            cellListView.reloadData()
        }else{
            let cell: NewsCell = collectionView.cellForItem(at: indexPath) as! NewsCell
            // 
            cell.homeViewController.navigationController?.pushViewController(newsViewController, animated: true)
            print(indexPath.item)
        }
    }
    
    func fetchData(d:Int) -> [String]{
        var data:[String]
        if(d == 0){
            data = First
        }else{
            data = second
        }
        return data
    }
    
    
}
