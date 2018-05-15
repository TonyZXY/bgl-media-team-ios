//
//  TransactionsController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 23/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift

var coinNameSelect:String = ""
var coinAbbNameSelect:String = ""
var exchangesNameSelect:String = ""
var tradingPairsNameSelect:String = ""
var tradingPairsAll = [String]()
var tradingPrice = ""
var transactionExpense:String = ""

class TransactionsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout{
    var cells = ["CoinTypeCell","CoinMarketCell","TradePairsCell","PriceCell","NumberCell","DateCell","TimeCell","ExpensesCell","AdditionalCell"]
    var selectedindex = 0
    var color = ThemeColor()
    var theme:ThemeColor!
    var transaction:String = "Buy"
    var prices:String = "kk"
    let cryptoCompareClient = CryptoCompareClient()
    let realm = try! Realm()
    var transactionItem = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color.themeColor()
        setupView()
        tabBarController?.tabBar.isHidden = true
        let titleLabel = UILabel()
        titleLabel.text = "Blockchain Global"
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.transactionTableView.reloadData()
            self.loadPrice()
        }
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
        button.setTitle("Add Transaction", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = color.riseColor()
        button.addTarget(self, action: #selector(addTransaction), for: .touchUpInside)
        return button
    }()
    
    @objc func addTransaction(){
       
        
        let newTransaction = Wallet()
        let index = IndexPath(row: 0, section: 0)
        let coinName = (transactionTableView.cellForRow(at: index) as! TransCoinTypeCell).coin.text!
        newTransaction.coinName = coinName
        let index1 = IndexPath(row: 1, section: 0)
        let marketName = (transactionTableView.cellForRow(at: index1) as! TransCoinMarketCell).market.text!
        newTransaction.exchangName = marketName
        newTransaction.priceChange = ""
        newTransaction.coinAbbName = coinAbbNameSelect
        newTransaction.tradingPairsName = tradingPairsNameSelect
        let index2 = IndexPath(row: 4, section: 0)
        let amount = Int((transactionTableView.cellForRow(at: index2) as! TransNumberCell).number.text!)!
        newTransaction.coinAmount = amount
        let index3 = IndexPath(row: 3, section: 0)
        let single = Float((transactionTableView.cellForRow(at: index3) as! TransPriceCell).price.text!)!
        newTransaction.singlePrice = single
        newTransaction.totalPrice = Float(amount) * single
        
        realm.beginWrite()
        if realm.object(ofType: Wallet.self, forPrimaryKey: newTransaction.coinName) == nil {
            realm.create(Wallet.self, value: [newTransaction.coinName, newTransaction.exchangName, newTransaction.priceChange, newTransaction.coinAbbName, newTransaction.tradingPairsName, newTransaction.coinAmount,newTransaction.totalPrice,newTransaction.singlePrice])
        } else {
            realm.create(Wallet.self, value: [newTransaction.coinName, newTransaction.exchangName, newTransaction.priceChange, newTransaction.coinAbbName, newTransaction.tradingPairsName, newTransaction.coinAmount,newTransaction.totalPrice,newTransaction.singlePrice], update: true)
        }
        try! realm.commitWrite()
        
        navigationController?.popViewController(animated: true)
    }
    
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
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-[v1(==v0)]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buy,"v1":sell,"v2":transactionTableView,"v3":transactionButton]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buy,"v1":sell,"v2":transactionTableView,"v3":transactionButton]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v1(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buy,"v1":sell,"v2":transactionTableView,"v3":transactionButton]))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v2]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buy,"v1":sell,"v2":transactionTableView,"v3":transactionButton]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-5-[v2]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buy,"v1":sell,"v2":transactionTableView,"v3":transactionButton]))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v3]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buy,"v1":sell,"v2":transactionTableView,"v3":transactionButton]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v2]-0-[v3(80)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":buy,"v1":sell,"v2":transactionTableView,"v3":transactionButton]))
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
            cell.backgroundColor = color.themeColor()
            cell.coin.text = coinNameSelect
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[1], for: indexPath) as! TransCoinMarketCell
            cell.backgroundColor = color.themeColor()
            cell.market.text = exchangesNameSelect
            return cell
        } else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[2], for: indexPath) as! TransTradePairsCell
            cell.backgroundColor = color.themeColor()
            if tradingPairsNameSelect == ""{
                cell.trade.text = ""
            } else {
                cell.trade.text = coinAbbNameSelect + "/" + tradingPairsNameSelect
            }
            return cell
        }else if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[3], for: indexPath) as! TransPriceCell
            if transaction == "Buy"{
                cell.priceLabel.text = "买入价格"
            } else if transaction == "Sell"{
                cell.priceLabel.text = "卖出价格"
            }
            return cell
        } else if indexPath.row == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[4], for: indexPath) as! TransNumberCell
            if transaction == "Buy"{
                cell.numberLabel.text = "购买数量"
            } else if transaction == "Sell"{
                cell.numberLabel.text = "出售数量"
            }
            return cell
        } else if indexPath.row == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[5], for: indexPath) as! TransDateCell
            if transaction == "Buy"{
                cell.dateLabel.text = "购买日期"
            } else if transaction == "Sell"{
                cell.dateLabel.text = "出售日期"
            }
            return cell
        } else if indexPath.row == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[6], for: indexPath) as! TransTimeCell
            if transaction == "Buy"{
                cell.timeLabel.text = "购买时间"
            } else if transaction == "Sell"{
                cell.timeLabel.text = "出售时间"
            }
            return cell
        } else if indexPath.row == 7{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[7], for: indexPath) as! TransExpensesCell
            cell.backgroundColor = color.themeColor()
            cell.changeText(input: tradingPairsAll)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[indexPath.row], for: indexPath)
            cell.backgroundColor = color.themeColor()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let searchdetail = SearchCoinController()
            navigationController?.pushViewController(searchdetail, animated: true)
        } else if indexPath.row == 1{
            let searchdetail = SearchExchangesController()
            navigationController?.pushViewController(searchdetail, animated: true)
        } else if indexPath.row == 2{
            let searchdetail = SearchTradingPairController()
            navigationController?.pushViewController(searchdetail, animated: true)
        }
    }
    
    func loadPrice(){
        if coinNameSelect != "" && exchangesNameSelect != "" && tradingPairsNameSelect != ""{
            cryptoCompareClient.getTradePrice(from: coinAbbNameSelect, to: tradingPairsNameSelect, exchange: exchangesNameSelect){ result in
                switch result{
                case .success(let resultData):
                    for(_, value) in resultData!{
                        let index = IndexPath(row: 3, section: 0)
                        let cell:TransPriceCell = self.transactionTableView.cellForRow(at: index) as! TransPriceCell
                        cell.price.text = String(value)
                    }
                case .failure(let error):
                    print("the error \(error.localizedDescription)")
                }
            }
        }
    }
}
