//
//  SearchTradingPair.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 4/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class SearchTradingPairController:ViewController,UITableViewDelegate,UITableViewDataSource{
    let cryptoCompareClient = CryptoCompareClient()
    var tableViews = UITableView()
    var color = ThemeColor()
    var allTradingPairs = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getExchangeList()
        setupView()
        

    }
    
    lazy var searchResult:UITableView = {
        tableViews.backgroundColor = color.themeColor()
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
        tradingPairsNameSelect = (table.textLabel?.text)!
        navigationController?.popViewController(animated: true)
    }
    
    func getExchangeList()->Void{
        cryptoCompareClient.getExchangeList(){ result in
            switch result{
            case .success(let resultData):
                //                print(resultData?.AllExchanges["BTCMarkets"]?.TradingPairs["BTC"] ?? "")
                guard let exchangePairs = resultData?.AllExchanges else {return}
                for(exc, _) in exchangePairs{
//                    var name = resultData?.AllExchanges["exchangesNameSelect"]?.TradingPairs["coinNameSelect"] ?? ""
//                    print(name)
                    self.allTradingPairs.append(exc)
                }
                DispatchQueue.main.async {
                    self.searchResult.reloadData()
                }
            case .failure(let error):
                print("the error \(error.localizedDescription)")
            }
        }
    }
}
