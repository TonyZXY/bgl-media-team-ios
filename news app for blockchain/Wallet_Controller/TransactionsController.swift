//
//  TransactionsController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 23/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

var coinNameSelect:String = ""
var exchangesNameSelect:String = ""
var tradingPairsNameSelect:String = ""
class TransactionsController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout{
    var cells = ["CoinTypeCell","CoinMarketCell","TradePairsCell","PriceCell","NumberCell","DateCell","TimeCell","ExpensesCell","AdditionalCell"]
    var selectedindex = 0
    var color = ThemeColor()
    var theme:ThemeColor!
    var transaction:String = "Buy"
    var prices:String = "kk"
    var gg = GetCoinData()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color.themeColor()
        setupView()
        tabBarController?.tabBar.isHidden = true
        let titleLabel = UILabel()
        titleLabel.text = "Blockchain Global"
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        gg.getExchangeList()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.transactionTableView.reloadData()
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
        let index = IndexPath(row: 3, section: 0)
        let cellss: TransPriceCell = transactionTableView.cellForRow(at: index) as! TransPriceCell
        print(cellss.price.text!)
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
        
//        for name in 1...{
//
//        }
        
//        let index = IndexPath(row: 3, section: 0)
//        let cellss: TransPriceCell = transactionTableView.cellForRow(at: index) as! TransPriceCell
//        print(cellss.price.text!)
        
    }
    
    @objc func sellPage(){
        transaction = "Sell"
        sell.layer.borderColor = color.redColor().cgColor
        buy.layer.borderColor = UIColor.lightGray.cgColor
        transactionButton.backgroundColor = color.redColor()
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
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cells[indexPath.row], for: indexPath)
            cell.backgroundColor = color.themeColor()
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let searchdetail = SearchDetailController()
            navigationController?.pushViewController(searchdetail, animated: true)
        } else if indexPath.row == 1{
            let searchdetail = SearchExchangesController()
            navigationController?.pushViewController(searchdetail, animated: true)
        } else if indexPath.row == 2{
            let searchdetail = SearchTradingPairController()
            navigationController?.pushViewController(searchdetail, animated: true)
        }
    }
}
