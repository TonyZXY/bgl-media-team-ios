//
//  SearchTradingPair.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 4/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class SearchTradingPairController:UIViewController,UITableViewDelegate,UITableViewDataSource{
    let cryptoCompareClient = CryptoCompareClient()
    var tableViews = UITableView()
    var color = ThemeColor()
    var allTradingPairs = [String]()
    let getDataResults = GetDataResult()
    var delegate:TransactionFrom?
    var selectValues:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        getTradingPairsList()
        setupView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTradingPairs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = allTradingPairs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let table:UITableViewCell = searchResult.cellForRow(at: indexPath)!
        delegate?.setTradingPairsSecondType(secondCoinType: [])
        var allPairs = [String]()
        allPairs.append((table.textLabel?.text)!)
        allPairs.append("%"+(table.textLabel?.text)!)
        delegate?.setTradingPairsName(tradingPairsName: (table.textLabel?.text)!)
        delegate?.setTradingPairsSecondType(secondCoinType: allPairs)
//        loadPrice(selectTradingPairs: (table.textLabel?.text)!)
//        print(selectValues)
//        delegate?.setPrice(price: selectValues)
        navigationController?.popViewController(animated: true)
    }
    
    func getTradingPairsList()->Void{
        let data = getDataResults.getTradingCoinList(market: (delegate?.getExchangeName())!,coin:(delegate?.getCoinName())!)
        if data != []{
            for pairs in data{
                self.allTradingPairs.append(pairs)
            }
        }
    }
    
    lazy var searchResult:UITableView = {
        tableViews.backgroundColor = color.themeColor()
        tableViews.rowHeight = 80
        tableViews.separatorInset = UIEdgeInsets.zero
        tableViews.delegate = self
        tableViews.dataSource = self
        tableViews.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableViews.translatesAutoresizingMaskIntoConstraints = false
        return tableViews
    }()
    
    func setupView(){
        view.addSubview(searchResult)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchResult]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchResult]))
        
        let tableVC = UITableViewController.init(style: .plain)
        tableVC.tableView = self.searchResult
        self.addChildViewController(tableVC)
    }
    
//    func loadPrice(selectTradingPairs:String){
//        let selectValue:String = ""
//        cryptoCompareClient.getTradePrice(from: (delegate?.getCoinName())!, to: selectTradingPairs, exchange: delegate?.getExchangeName()){ result in
//                switch result{
//                case .success(let resultData):
//                    for result in resultData!{
//                        self.selectValues = String(result.value)
//                        print(self.selectValues)
//                    }
//                case .failure(let error):
//                    print("the error \(error.localizedDescription)")
//                }
//            }
//        } else{
//            selectValue = ""
//            return selectValue
//        }
//    }
}
