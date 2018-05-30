//
//  TransactionsController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 21/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import RealmSwift

class TransactionsHistoryController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    let realm = try! Realm()
    var results = try! Realm().objects(AllTransactions.self)
    var indexSelected:Int = 0
    var generalData = generalDetail()
    var priceType = "AUD"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filterName = "coinAbbName = '" + generalData.coinAbbName + "' "
        results = realm.objects(AllTransactions.self).filter(filterName)
             NotificationCenter.default.addObserver(self, selector: #selector(handleRefresh(_:)), name: NSNotification.Name(rawValue: "reloadWallet"), object: nil)
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "reloadWallet"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = results[indexPath.row]
        if object.status == "Buy"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BuyHistory", for: indexPath) as! HistoryTableViewCell
            cell.dateLabel.textColor = UIColor.white
            cell.buyMarket.textColor = UIColor.white
            cell.labelPoint.text = "B"
            cell.labelPoint.layer.backgroundColor = ThemeColor().greenColor().cgColor
            cell.dateLabel.text = object.date + " " + object.time
            cell.buyMarket.text = "交易市场:" + object.exchangName
            cell.SinglePrice.text = object.coinAbbName + " " + object.status + " " + "Price"
            cell.amount.text = "Amount" + " " + object.status
            cell.SinglePriceResult.text = scientificMethod(number:object.audSinglePrice)
            cell.tradingPairsResult.text = object.tradingPairsName
            cell.amountResult.text = scientificMethod(number:object.amount)
            cell.costResult.text = scientificMethod(number:object.audTotalPrice)
            cell.buyDeleteButton.tag = object.id
            cell.buyDeleteButton.addTarget(self, action: #selector(deleteTransaction), for: .touchUpInside)
            let filterName = "coinAbbName = '" + object.coinAbbName + "' "
            let currentWorth = try! Realm().objects(MarketTradingPairs.self).filter(filterName)
            var currentWorthData:Double = 0
            for value in currentWorth{
                currentWorthData = value.singlePrice * object.amount
            }
            cell.worthResult.text = scientificMethod(number:currentWorthData)
            let delta = ((currentWorthData - object.totalPrice) / object.totalPrice) * 100
            cell.deltaResult.text = scientificMethod(number:delta) + "%"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy, h:ma"
            return cell
        } else if object.status == "Sell"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SellHistory", for: indexPath) as! HistoryTableViewCell
            cell.sellDateLabel.textColor = UIColor.white
            cell.sellMarket.textColor = UIColor.white
            cell.labelPoint.text = "S"
            cell.labelPoint.layer.backgroundColor = ThemeColor().redColor().cgColor
            cell.sellDateLabel.text = object.date + " " + object.time
            cell.sellPrice.text = object.coinAbbName + " " + object.status + " " + "Price"
            cell.sellTradingPairs.text = object.coinAbbName + "/" + object.tradingPairsName
            cell.sellPriceResult.text = scientificMethod(number:object.singlePrice)
            cell.sellTradingPairs.text = object.coinAbbName + "/" + object.tradingPairsName
            cell.sellAmountResult.text = scientificMethod(number:object.amount)
            cell.sellProceedsResult.text = scientificMethod(number:object.totalPrice)
            cell.sellDeleteButton.tag = object.id
            cell.sellDeleteButton.addTarget(self, action: #selector(deleteTransaction), for: .touchUpInside)
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transactionForm = TransactionsController()
//        let cell = self.historyTableView.cellForRow(at: indexPath) as! HistoryTableViewCell
        transactionForm.updateTransaction = results[indexPath.row]
        transactionForm.transactionStatus = "Update"
        navigationController?.pushViewController(transactionForm, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
    }
    
    @objc func deleteTransaction(sender:UIButton){
        let filterName = "id = " + String(sender.tag)
        var name:String = ""
        let statusItem = realm.objects(AllTransactions.self).filter(filterName)
        if statusItem.count == 1{
            for value in statusItem{
                name = "coinAbbName = '" + value.coinAbbName + "' "
            }
            let coinSelected = realm.objects(MarketTradingPairs.self).filter(name)
            try! realm.write {
                realm.delete(coinSelected)
            }
        }
        try! realm.write {
            realm.delete(statusItem)
        }
        historyTableView.reloadData()
    }
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        return refreshControl
    }()
    
    func setUpView(){
        view.backgroundColor = ThemeColor().themeColor()
        view.addSubview(historyTableView)
        view.addSubview(averageView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: averageView)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: averageView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: historyTableView,averageView)
        view.addConstraintsWithFormat(format: "V:[v1]-0-[v0]|", views: historyTableView,averageView)
    }
    
    lazy var historyTableView:UITableView = {
        var tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = ThemeColor().themeColor()
        let timelineTableViewCellNib = UINib(nibName: "TimeHistoryTableViewCell", bundle: Bundle(for: HistoryTableViewCell.self))
        let SellTableViewCellNib = UINib(nibName: "SellTableViewCell", bundle: Bundle(for: HistoryTableViewCell.self))
        tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "BuyHistory")
        tableView.register(SellTableViewCellNib, forCellReuseIdentifier: "SellHistory")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 200
        tableView.delegate = self
        tableView.dataSource = self
        
        //Prevent empty rows
        tableView.tableFooterView = UIView()
//        tableView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2039215686, blue: 0.2235294118, alpha: 1)
        tableView.separatorStyle = .none
        tableView.addSubview(self.refresher)
        return tableView
    }()
    
    func setWalletData() -> [WalletDetail]{
        var wallets = [WalletDetail]()
        var list = [String]()
        let allResult = realm.objects(AllTransactions.self)
        let coinSelected = realm.objects(MarketTradingPairs.self)
        for value in allResult{
            if list.contains(value.coinName){
                let indexs = wallets.index(where: { (item) -> Bool in
                    item.coinName == value.coinName
                })
                let filterName = "coinAbbName = '" + value.coinAbbName + "' "
                let coinSelected = coinSelected.filter(filterName)
                if coinSelected.count == 0{
                    wallets[indexs!].tradingPairsName = value.tradingPairsName
                    wallets[indexs!].exchangeName = value.exchangName
                } else {
                    for result in coinSelected{
                        wallets[indexs!].exchangeName = result.exchangeName
                        wallets[indexs!].tradingPairsName = result.tradingPairsName
                    }
                }
                if value.status == "Buy"{
                    if priceType == "AUD"{
                        wallets[indexs!].coinAmount += value.amount
                        wallets[indexs!].TransactionPrice += value.audTotalPrice
                    }
                }else if value.status == "Sell"{
                    wallets[indexs!].coinAmount -= value.amount
                    if priceType == "AUD"{
                        wallets[indexs!].TransactionPrice -= value.audTotalPrice
                    }
                }
            } else{
                let newWallet = WalletDetail()
                newWallet.coinName = value.coinName
                newWallet.exchangeName = value.exchangName
                newWallet.coinAbbName = value.coinAbbName
                newWallet.coinAmount = value.amount
                newWallet.TransactionPrice = value.audTotalPrice
                newWallet.tradingPairsName = value.tradingPairsName
                wallets.append(newWallet)
                list.append(value.coinName)
            }
        }
        return wallets
    }
    
    var averageView:UIView = {
        var view = UIView()
        view.backgroundColor = ThemeColor().themeColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        historyTableView.reloadData()
        self.refresher.endRefreshing()
    }

}
