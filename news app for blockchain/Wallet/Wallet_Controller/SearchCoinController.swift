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
    let cryptoCompareClient = CryptoCompareClient()
    var color = ThemeColor()
    let realm = try! Realm()
    var allCoinObject = [CryptoCompareCoinsRealm]()
    weak var delegate:TransactionFrom?
    var filterObject = [CryptoCompareCoinsRealm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        searchBar.becomeFirstResponder()
        searchBar.returnKeyType = UIReturnKeyType.done
        
//        let filterName = "coinAbbName = '" + (delegate?.getCoinName())! + "' "
//        if delegate?.getCoinName() != ""{
//            let result = try! Realm().objects(CryptoCompareCoinsRealm.self).filter(filterName)
//            for n in result {
//                allCoinObject.append(n)
//            }
//        } else {
//            let result = try! Realm().objects(CryptoCompareCoinsRealm.self)
//            for n in result {
//                allCoinObject.append(n)
//            }
//        }

        let result = try! Realm().objects(CryptoCompareCoinsRealm.self)
        for n in result {
            allCoinObject.append(n)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filterObject.count
        }
        return allCoinObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coins", for: indexPath) as! CoinTypeTableViewCell
        if isSearching{
            cell.coinName.text = filterObject[indexPath.row].CoinName
            cell.coinNameAbb.text = filterObject[indexPath.row].Name
            cell.coinImage.coinImageSetter(coinName: filterObject[indexPath.row].Name, width: 30, height: 30, fontSize: 5)
        } else {
            cell.coinName.text = allCoinObject[indexPath.row].CoinName
            cell.coinNameAbb.text = allCoinObject[indexPath.row].Name
            cell.coinImage.coinImageSetter(coinName: allCoinObject[indexPath.row].Name, width: 30, height: 30, fontSize: 5)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let table:CoinTypeTableViewCell = searchResult.cellForRow(at: indexPath) as! CoinTypeTableViewCell
        delegate?.setCoinName(name: table.coinName.text!)
        delegate?.setCoinAbbName(abbName: table.coinNameAbb.text!)
        delegate?.setTradingPairsName(tradingPairsName: "")
        delegate?.setTradingPairsFirstType(firstCoinType: [])
        delegate?.setTradingPairsSecondType(secondCoinType: [])
        delegate?.setExchangesName(exchangeName: "")
        var allPairs = [String]()
        allPairs.append(table.coinNameAbb.text!)
        allPairs.append("%"+table.coinNameAbb.text!)
        delegate?.setTradingPairsFirstType(firstCoinType: allPairs)
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
            var result = [String]()
            for n in allCoinObject{
                result.append(n.Name)
            }
            filterObject = allCoinObject.filter({(mod) -> Bool in return mod.CoinName.lowercased().contains(searchBar.text!.lowercased())})
            searchResult.reloadData()
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
        
        let tableVC = UITableViewController.init(style: .plain)
        tableVC.tableView = self.searchResult
        self.addChildViewController(tableVC)
    }
    
}
