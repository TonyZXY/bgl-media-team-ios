//
//  SearchDetailController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 24/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift

class SearchCoinController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    var tableViews = UITableView()
    var isSearching = false
    var filteringdata = [String]()
    var filteringdata1 = [String:String]()
    var filterName = [String]()
    var filterNameAbb = [String]()
    var coinNameItem = [String]()
    var coinAbbItem = [String]()
    var coinAllAbb = [String]()
    var coinAllName = [String]()
    var coinDetail = [String:String]()
    let cryptoCompareClient = CryptoCompareClient()
    var color = ThemeColor()
    let realm = try! Realm()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteringdata1.count
        }
        return coinNameItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coins", for: indexPath) as! CoinTypeTableViewCell
        if isSearching{
            cell.coinName.text = filterName[indexPath.row]
            cell.coinNameAbb.text = filterNameAbb[indexPath.row]
        } else {
            cell.coinName.text = coinAllName[indexPath.row]
            cell.coinNameAbb.text = coinAllAbb[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let table:CoinTypeTableViewCell = searchResult.cellForRow(at: indexPath) as! CoinTypeTableViewCell
        coinNameSelect = table.coinName.text!
        coinAbbNameSelect = table.coinNameAbb.text!
        tradingPairsAll.removeAll()
        tradingPairsAll.append(coinAbbNameSelect)
        tradingPairsAll.append("%"+coinAbbNameSelect)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            view.endEditing(true)
            searchResult.reloadData()
        } else{
            isSearching = true
            //            filteringdata = coinNameItem.filter{coinName in return coinName.lowercased().contains(searchBar.text!.lowercased())}
            filteringdata1 = coinDetail.filter{ haha in return haha.value.lowercased().contains(searchBar.text!.lowercased())}
            filterName = [String]()
            filterNameAbb = [String]()
            filterName.append(contentsOf: filteringdata1.values)
            filterNameAbb.append(contentsOf: filteringdata1.keys)
            searchResult.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let result = try! Realm().objects(CryptoCompareCoinsRealm.self)
        for n in result {
            self.coinDetail[n.Name] = n.CoinName
            self.coinAllAbb.append(n.Name)
            self.coinAllName.append(n.CoinName)
        }
        DispatchQueue.main.async {
            self.searchResult.reloadData()
        }
    }
    
    
    lazy var searchBar:UISearchBar={
        var searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.barTintColor = color.walletCellcolor()
        searchBar.tintColor = color.themeColor()
        searchBar.backgroundColor = color.fallColor()
        return searchBar
    }()
    
    lazy var searchResult:UITableView = {
        tableViews.separatorInset = UIEdgeInsets.zero
        tableViews.backgroundColor = color.themeColor()
        tableViews.separatorColor = ThemeColor().themeColor()
        tableViews.delegate = self
        tableViews.dataSource = self
        tableViews.register(CoinTypeTableViewCell.self, forCellReuseIdentifier: "coins")
        tableViews.translatesAutoresizingMaskIntoConstraints = false
        return tableViews
    }()
    
    func setupView(){
        view.addSubview(searchBar)
        view.addSubview(searchResult)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchBar]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchBar]))
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchBar,"v1":searchResult]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchBar,"v1":searchResult]))
    }
    
}
