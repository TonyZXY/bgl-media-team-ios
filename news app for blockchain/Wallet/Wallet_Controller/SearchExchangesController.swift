//
//  SearchExchangesController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 4/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class SearchExchangesController:UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    let cryptoCompareClient = CryptoCompareClient()
    var tableViews = UITableView()
    var color = ThemeColor()
    var allExchanges = [String]()
    var filterExchanges = [String]()
    var isSearching = false
    let getDataResult = GetDataResult()
    override func viewDidLoad() {
        super.viewDidLoad()
        getExchangeList()
        setupView()
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
        tableViews.rowHeight = 80
        tableViews.separatorInset = UIEdgeInsets.zero
        tableViews.backgroundColor = color.themeColor()
        tableViews.delegate = self
        tableViews.dataSource = self
        tableViews.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filterExchanges.count
        }
        return allExchanges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if isSearching{
            cell.textLabel?.text = filterExchanges[indexPath.row]
        } else {
            cell.textLabel?.text = allExchanges[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let table:UITableViewCell = searchResult.cellForRow(at: indexPath)!
        exchangesNameSelect = (table.textLabel?.text)!
        navigationController?.popViewController(animated: true)
    }
    
    
    
    func getExchangeList()->Void{
        let data = getDataResult.getExchangeList()
        for (key,_) in data{
            self.allExchanges.append(key)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            view.endEditing(true)
            searchResult.reloadData()
        } else{
            isSearching = true
            filterExchanges = allExchanges.filter{ name in return name.lowercased().contains(searchBar.text!.lowercased())}
            searchResult.reloadData()
        }
    }
}

class ExchangesCell:UITableViewCell{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    var exchangeName:UILabel = {
        var label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView(){
        addSubview(exchangeName)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":exchangeName]))
        NSLayoutConstraint(item: exchangeName, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
