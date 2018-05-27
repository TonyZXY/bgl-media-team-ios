//
//  TransactionsController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 23/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift

class TransactionsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout,TransactionFrom,UITextFieldDelegate{

    var newTransaction = AllTransactions()
    var cells = ["CoinTypeCell","CoinMarketCell","TradePairsCell","PriceCell","NumberCell","DateCell","TimeCell","ExpensesCell","AdditionalCell"]
    var color = ThemeColor()
    var transaction:String = "Buy"
    let cryptoCompareClient = CryptoCompareClient()
    let realm = try! Realm()
    var priceCurrency:Double = 0.0
    var transcationData = TransactionFormData()
    var updateTransaction = AllTransactions()
    var transactionStatus = "Add"
    var transactionNumber:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateTransactionDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        DispatchQueue.main.async {
            self.loadPrice()
            self.transactionTableView.reloadData()
        }
    }
    
    func updateTransactionDetail(){
        print(updateTransaction.amount)
        if transactionStatus == "Update"{
            transactionNumber = 1
            newTransaction.id = updateTransaction.id
            newTransaction.coinAbbName = updateTransaction.coinAbbName
            newTransaction.coinName = updateTransaction.coinName
            newTransaction.exchangName = updateTransaction.exchangName
            newTransaction.tradingPairsName = updateTransaction.tradingPairsName
            newTransaction.singlePrice = updateTransaction.singlePrice
            newTransaction.amount = updateTransaction.amount
            newTransaction.date = updateTransaction.date
            newTransaction.time = updateTransaction.time
            newTransaction.expenses = updateTransaction.expenses
            newTransaction.additional = updateTransaction.additional
            transcationData.tradingPairsFirst = [newTransaction.coinAbbName,"%" + newTransaction.coinAbbName]
            transcationData.tradingPairsSecond = [newTransaction.tradingPairsName, "%" + newTransaction.coinAbbName]
        }
    }
    
    @objc func addTransaction(){
        newTransaction.totalPrice = Double(newTransaction.amount) * newTransaction.singlePrice
        newTransaction.status = transaction
        if newTransaction.coinName != "" && newTransaction.coinName != "" && newTransaction.exchangName != "" && newTransaction.tradingPairsName != "" && String(newTransaction.amount) != "0.0" && String(newTransaction.singlePrice) != "0.0"{
            transactionButton.setTitle("Loading...", for: .normal)
            GetDataResult().getCryptoCurrencyApi(from: self.newTransaction.tradingPairsName, to: "USD", price: self.newTransaction.singlePrice){success,price in
                if success{
                    self.newTransaction.usdSinglePrice = price
                    self.newTransaction.usdTotalPrice = self.newTransaction.usdSinglePrice * Double(self.newTransaction.amount)
                } else{
                    print("fail")
                }
                
            }
            GetDataResult().getCryptoCurrencyApi(from: self.newTransaction.tradingPairsName, to: "AUD", price: self.newTransaction.singlePrice){success,price in
                if success{
                    self.newTransaction.audSinglePrice = price
                    self.newTransaction.audTotalPrice = self.newTransaction.audSinglePrice * Double(self.newTransaction.amount)
                    DispatchQueue.main.sync{
                        print(self.newTransaction.singlePrice)
                        self.writeToRealm()
                    }
                    
                } else{
                    print("fail")
                }
            }
        }
    }
    
    func writeToRealm(){
        //Write to Transaction Model to realm
        realm.beginWrite()
        var currentTransactionId:Int = 0
        if transactionStatus == "Update"{
            currentTransactionId = newTransaction.id
        } else {
            let transaction = realm.objects(AllTransactions.self)
            if transaction.count != 0{
                currentTransactionId = (transaction.last?.id)! + 1
            } else {
                currentTransactionId = 1
            }
        }
        
        let realmData:[Any] = [currentTransactionId,newTransaction.status,newTransaction.coinName,newTransaction.coinAbbName,newTransaction.exchangName, newTransaction.tradingPairsName,newTransaction.singlePrice,newTransaction.totalPrice,newTransaction.amount,newTransaction.date,newTransaction.time,newTransaction.expenses,newTransaction.additional,newTransaction.usdSinglePrice,newTransaction.usdTotalPrice,newTransaction.audSinglePrice,newTransaction.audTotalPrice]
        
        if realm.object(ofType: AllTransactions.self, forPrimaryKey: currentTransactionId) == nil {
            realm.create(AllTransactions.self, value: realmData)
        } else {
            print("success123")
            realm.create(AllTransactions.self, value: realmData, update: true)
        }
        
        try! realm.commitWrite()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadWallet"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    lazy var transactionTableView:UITableView = {
        var tableViews = UITableView()
        tableViews.backgroundColor = color.themeColor()
        tableViews.register(TransCoinTypeCell.self, forCellReuseIdentifier: "CoinTypeCell")
        tableViews.register(TransCoinMarketCell.self, forCellReuseIdentifier: "CoinMarketCell")
        tableViews.register(TransTradePairsCell.self, forCellReuseIdentifier: "TradePairsCell")
        tableViews.register(TransPriceCell.self, forCellReuseIdentifier: "PriceCell")
        tableViews.register(TransNumberCell.self, forCellReuseIdentifier: "NumberCell")
        tableViews.register(TransDateCell.self, forCellReuseIdentifier: "DateCell")
        tableViews.register(TransTimeCell.self, forCellReuseIdentifier: "TimeCell")
        tableViews.register(TransExpensesCell.self, forCellReuseIdentifier: "ExpensesCell")
        tableViews.register(TransAdditionalCell.self, forCellReuseIdentifier: "AdditionalCell")
        tableViews.delegate = self
        tableViews.dataSource = self
        tableViews.separatorStyle = .none
        return tableViews
    }()
    
    lazy var transactionButton:UIButton = {
        var button = UIButton(type: .system)
        if transactionStatus == "Add" {
            button.setTitle("Add Transaction", for: .normal)
        } else if transactionStatus == "Update" {
            button.setTitle("Update Transaction", for: .normal)
        }
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = color.riseColor()
        return button
    }()
    
    lazy var buy:UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Buy", for: .normal)
        button.tintColor = UIColor.white
        button.layer.borderColor = color.greenColor().cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(buyPage), for: .touchUpInside)
        return button
    }()
    
    lazy var sell:UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Sell", for: .normal)
        button.tintColor = UIColor.white
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(sellPage), for: .touchUpInside)
        return button
    }()
    
    @objc func buyPage(){
        transaction = "Buy"
        buy.layer.borderColor = color.greenColor().cgColor
        sell.layer.borderColor = UIColor.lightGray.cgColor
        transactionButton.backgroundColor = color.greenColor()        
        DispatchQueue.main.async {
            self.transactionTableView.reloadData()
        }
    }
    
    @objc func sellPage(){
        transaction = "Sell"
        sell.layer.borderColor = color.redColor().cgColor
        buy.layer.borderColor = UIColor.lightGray.cgColor
        transactionButton.backgroundColor = color.redColor()
        DispatchQueue.main.async {
            self.transactionTableView.reloadData()
        }
    }
    
    func setupView(){
        view.backgroundColor = color.themeColor()
        let titleLabel = UILabel()
        titleLabel.text = "Blockchain Global"
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        
        transactionTableView.keyboardDismissMode = .onDrag
        
        navigationController?.navigationBar.barTintColor =  color.themeColor()
        navigationController?.navigationBar.isTranslucent = false
        view.addSubview(transactionButton)
        view.addSubview(transactionTableView)
        view.addSubview(buy)
        view.addSubview(sell)
        buy.translatesAutoresizingMaskIntoConstraints = false
        sell.translatesAutoresizingMaskIntoConstraints = false
        transactionTableView.translatesAutoresizingMaskIntoConstraints = false
        transactionButton.translatesAutoresizingMaskIntoConstraints = false
        transactionButton.addTarget(self, action: #selector(addTransaction), for: .touchUpInside)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-[v1(==v0)]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buy,"v1":sell,"v2":transactionTableView,"v3":transactionButton]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buy,"v1":sell,"v2":transactionTableView,"v3":transactionButton]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v1(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buy,"v1":sell,"v2":transactionTableView,"v3":transactionButton]))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v2]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buy,"v1":sell,"v2":transactionTableView,"v3":transactionButton]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-5-[v2]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buy,"v1":sell,"v2":transactionTableView,"v3":transactionButton]))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v3]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buy,"v1":sell,"v2":transactionTableView,"v3":transactionButton]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v2]-0-[v3(80)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buy,"v1":sell,"v2":transactionTableView,"v3":transactionButton]))
        
        let tableVC = UITableViewController.init(style: .plain)
        tableVC.tableView = self.transactionTableView
        self.addChildViewController(tableVC)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[0], for: indexPath) as! TransCoinTypeCell
            cell.coin.text = newTransaction.coinName
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[1], for: indexPath) as! TransCoinMarketCell
            cell.backgroundColor = color.themeColor()
            cell.market.text = newTransaction.exchangName
            return cell
        } else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[2], for: indexPath) as! TransTradePairsCell
            if newTransaction.tradingPairsName == ""{
                cell.trade.text = ""
            } else {
                if newTransaction.tradingPairsName != ""{
                    cell.trade.text = newTransaction.coinAbbName + "/" + newTransaction.tradingPairsName
                }
            }
            return cell
        }else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[3], for: indexPath) as! TransPriceCell
            if transaction == "Buy"{
                cell.priceLabel.text = "买入价格" + " " + newTransaction.tradingPairsName
            } else if transaction == "Sell"{
                cell.priceLabel.text = "卖出价格" + " " + newTransaction.tradingPairsName
            }
            cell.price.text = scientificMethod(number: newTransaction.singlePrice)
            cell.price.tag = indexPath.row
            cell.priceType.tag = 10
            cell.priceType.delegate = self
            cell.price.delegate = self
            return cell
        } else if indexPath.row == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[4], for: indexPath) as! TransNumberCell
            if transaction == "Buy"{
                cell.numberLabel.text = "购买数量"
            } else if transaction == "Sell"{
                cell.numberLabel.text = "出售数量"
            }
            cell.number.text = String(newTransaction.amount)
            cell.number.tag = indexPath.row
            cell.number.delegate = self
            cell.number.clearsOnBeginEditing = true
            return cell
        } else if indexPath.row == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[5], for: indexPath) as! TransDateCell
            if transaction == "Buy"{
                cell.dateLabel.text = "购买日期"
            } else if transaction == "Sell"{
                cell.dateLabel.text = "出售日期"
            }
            cell.date.text = String(newTransaction.date)
            cell.date.tag = indexPath.row
            textFieldDidEndEditing(cell.date)
            cell.date.delegate = self
            return cell
        } else if indexPath.row == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[6], for: indexPath) as! TransTimeCell
            if transaction == "Buy"{
                cell.timeLabel.text = "购买时间"
            } else if transaction == "Sell"{
                cell.timeLabel.text = "出售时间"
            }
            cell.time.text = String(newTransaction.time)
            cell.time.tag = indexPath.row
            textFieldDidEndEditing(cell.time)
            cell.time.delegate = self
            return cell
        } else if indexPath.row == 7{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[7], for: indexPath) as! TransExpensesCell
            cell.changeText(first: transcationData.tradingPairsFirst,second:transcationData.tradingPairsSecond)
            cell.expenses.text = String(newTransaction.expenses)
            cell.expenses.tag = indexPath.row
            cell.expenses.delegate = self
            return cell
        }else if indexPath.row == 8{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[8], for: indexPath) as! TransAdditionalCell
            cell.additional.text = newTransaction.additional
            cell.additional.tag = indexPath.row
            cell.additional.delegate = self
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let searchdetail = SearchCoinController()
            searchdetail.delegate = self
            navigationController?.pushViewController(searchdetail, animated: true)
        } else if indexPath.row == 1{
            let searchdetail = SearchExchangesController()
            searchdetail.delegate = self
            navigationController?.pushViewController(searchdetail, animated: true)
        } else if indexPath.row == 2{
            let searchdetail = SearchTradingPairController()
            searchdetail.delegate = self
            navigationController?.pushViewController(searchdetail, animated: true)
        }
    }
    
    func loadPrice(){
        if transactionNumber == 1 {
            transactionNumber = 0
        } else {
            var readData:Double = 0
            if newTransaction.coinName != "" && newTransaction.exchangName != "" && newTransaction.tradingPairsName != ""{
                cryptoCompareClient.getTradePrice(from: newTransaction.coinAbbName, to: newTransaction.tradingPairsName, exchange: newTransaction.exchangName){
                    result in
                    switch result{
                    case .success(let resultData):
                        for(_, value) in resultData!{
                            readData = value
                        }
                        let index = IndexPath(row: 3, section: 0)
                        let cell:TransPriceCell = self.transactionTableView.cellForRow(at: index) as! TransPriceCell
                        cell.price.text = self.scientificMethod(number: readData)
                        self.newTransaction.singlePrice = Double(String(readData))!
                    //                                        self.textFieldDidEndEditing(cell.price)
                    case .failure(let error):
                        print("the error \(error.localizedDescription)")
                    }
                }
            } else{
                newTransaction.singlePrice = 0
            }
        }
        
        
//        let index = IndexPath(row: 3, section: 0)
//        let cell:TransPriceCell = self.transactionTableView.cellForRow(at: index) as! TransPriceCell
//        if cell.priceType.text == "总额" {
//            cell.price.text = String(newTransaction.singlePrice * newTransaction.amount)
//        } else{
//            cell.price.text = String(newTransaction.singlePrice)
//        }
    }
    
    func getExchangeName() -> String {
        return newTransaction.exchangName
    }
    
    func getCoinName() -> String {
        return newTransaction.coinAbbName
    }
    
    
    func setTradingPairsFirstType(firstCoinType: [String]) {
        transcationData.tradingPairsFirst = firstCoinType
    }
    
    func setTradingPairsSecondType(secondCoinType: [String]) {
        transcationData.tradingPairsSecond = secondCoinType
    }
    
    func setCoinName(name: String) {
        newTransaction.coinName = name
    }
    
    func setCoinAbbName(abbName: String) {
        newTransaction.coinAbbName = abbName
    }
    
    func setExchangesName(exchangeName: String) {
        newTransaction.exchangName = exchangeName
    }
    
    func setTradingPairsName(tradingPairsName: String) {
        newTransaction.tradingPairsName = tradingPairsName
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 3{
            if textField.text == "" || textField.text == nil{
                textField.text = "0"
            }
            newTransaction.singlePrice = Double(textField.text!)!
        }
        if textField.tag == 4{
            if textField.text == "" || textField.text == nil{
                textField.text = "0"
            }
            newTransaction.amount = Double(textField.text!)!
            self.newTransaction.usdTotalPrice = newTransaction.usdSinglePrice * Double(self.newTransaction.amount)
            self.newTransaction.audTotalPrice = newTransaction.audSinglePrice * Double(self.newTransaction.amount)
        }
        if textField.tag == 5{
            newTransaction.date = textField.text!
        }
        if textField.tag == 6{
            newTransaction.time = textField.text!
        }
        if textField.tag == 7{
            newTransaction.expenses = textField.text!
        }
        if textField.tag == 8{
            newTransaction.additional = textField.text!
        }
    }
}
