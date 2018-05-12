//
//  WatchlistCell.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 1/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift

class WatchList: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, SortPickerViewDelegate, UpdateWatchDelegate {
    
    var marketSortPickerView = MarketSortPickerView()
    var sortitems = ["按字母排序","按最高价排序"]
    var sortdate = ["1W","1D","1H"]
    var coinitems = ["bitcoin","haha"]
    let pickerview = UIPickerView()
    var color = ThemeColor()
    var colors = ThemeColor()
    
    var coinSymbolRealm = try! Realm().objects(CoinsInWatchListRealm.self)
    var tickerDataRealmObjects = try! Realm().objects(TickerDataRealm.self)
    
    var filterDateSelection: Int?
    
    weak var removeWatchInMarketsCellDelegate: UpdateWatchDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        getCoinWatchList()
        marketSortPickerView.sortPickerViewDelegate = self
    }
    
    //排序按钮
    let sortCoin:UITextField={
        var sort = UITextField()
        sort.tintColor = .clear
        sort.layer.borderColor = UIColor.white.cgColor
        sort.textColor = UIColor.white
        return sort
    }()
    
    //时间分类
    lazy var sortDate:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collect = UICollectionView(frame: .zero, collectionViewLayout:layout)
        collect.backgroundColor = color.themeColor()
        //        collect.layer.borderWidth = 1
        //        collect.layer.borderColor = UIColor.white.cgColor
        collect.delegate = self
        collect.dataSource = self
        return collect
    }()
    
    //币种列表
    lazy var coinList:UITableView = {
        var coinlist=UITableView()
        coinlist.backgroundColor = color.themeColor()
        coinlist.separatorStyle = .none
        coinlist.rowHeight = 100
        coinlist.delegate = self
        coinlist.dataSource = self
        return coinlist
    }()
    
    func setupView(){
        addSubview(marketSortPickerView)
        addSubview(sortDate)
        addSubview(coinList)
        //排序按钮
        marketSortPickerView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":marketSortPickerView,"v1":self]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0(20)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":marketSortPickerView,"v1":self]))
        
        //时间分类 Constraints
        sortDate.translatesAutoresizingMaskIntoConstraints = false
        sortDate.register(MarketFilterCollectionView.self, forCellWithReuseIdentifier: "SortDate")
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(200)]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":sortDate,"v1":marketSortPickerView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0(20)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":sortDate,"v1":self,"v2":marketSortPickerView]))
        
        //币种列表
        coinList.translatesAutoresizingMaskIntoConstraints = false
        coinList.register(MarketsCoinTableViewCell.self, forCellReuseIdentifier: "cellid")
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinList,"v1":marketSortPickerView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1]-10-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinList,"v1":marketSortPickerView]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //筛选日期
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SortDate", for: indexPath) as! MarketFilterCollectionView
        cell.label.text = sortdate[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:sortDate.frame.width / 3, height: sortDate.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //收藏列表
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinSymbolRealm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! MarketsCoinTableViewCell
        cell.backgroundColor = color.themeColor()
        cell.checkRiseandfall(risefallnumber: cell.coinChange.text!)
        
        let object = tickerDataRealmObjects[indexPath.row]

        cell.priceChange = [object.percent_change_7d, object.percent_change_24h, object.percent_change_1h][filterDateSelection ?? 0]
        cell.object = object
        cell.removeWatchInWatchListDelegate = self
        cell.removeWatchInMarketsCellDelegate = removeWatchInMarketsCellDelegate
        
        return cell
    }
    
    func getCoinWatchList() {
        let allCoinsSymbol = coinSymbolRealm.map {$0.symbol}
        tickerDataRealmObjects = tickerDataRealmObjects.filter("symbol in %@", Array(allCoinsSymbol))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sortDate {
            filterDateSelection = indexPath.row
            coinList.reloadData()
        }
    }
    
    func reloadDataSortedByName() {
        tickerDataRealmObjects = tickerDataRealmObjects.sorted(byKeyPath: "symbol", ascending: true)
        coinList.reloadData()
    }
    
    func reloadDataSortedByPrice() {
        tickerDataRealmObjects = tickerDataRealmObjects.sorted(byKeyPath: "price", ascending: false)
        coinList.reloadData()
    }
    
    func reloadDataAfterUpdateWatchList() {
        print("reload data")
        getCoinWatchList()
        coinList.reloadData()
    }
}


@objc protocol UpdateWatchDelegate: class {
    @objc optional func reloadDataAfterUpdateWatchList()
}

