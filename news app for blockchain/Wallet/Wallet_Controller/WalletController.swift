//
//  WalletController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 3/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift

class WalletController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var color = ThemeColor()
    var image = AppImage()
    let realm = try! Realm()
    var allResult = try! Realm().objects(AllTransactions.self)
    let cryptoCompareClient = CryptoCompareClient()
    var activityIndicator = UIActivityIndicatorView()
    let container = try! Container()
    var walletResults = [WalletDetail]()
    var displayType:String = "Number"
    let priceType:String = "AUD"
    var totalPrice:Float = 0
    var totalProfit:Float = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        SetDataResult().writeJsonExchange()
        print(allResult)
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        DispatchQueue.main.async {
            self.totalPrice = 0
            self.totalProfit = 0
            self.walletResults = self.setWalletData()
            self.walletList.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walletResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletCell", for: indexPath) as! WalletsCell
        let object = walletResults[indexPath.row]
        cell.coinName.text = object.coinName
        cell.coinAmount.text = String(object.coinAmount) + object.coinAbbName


        
        cryptoCompareClient.getTradePrice(from: object.coinAbbName, to: object.tradingPairsName, exchange: object.exchangeName){ result in
            switch result{
            case .success(let resultData):
                for results in resultData!{
                    var single = Float(results.value)
                    
                    if self.priceType == "USD"{
                        GetDataResult().getCryptoCurrencyApi(from: object.tradingPairsName, to: "USD", price: single){success,price in
                            if success{
                                single = price
                                
                            } else{
                                print("fail")
                            }
                        }
                    } else if self.priceType == "AUD"{
                        GetDataResult().getCryptoCurrencyApi(from: object.tradingPairsName, to: "AUD", price: single){success,price in
                            if success{
                                DispatchQueue.main.async {
                                    cell.coinSinglePrice.text = String(price)
                                    let total = Float(price) * Float(object.coinAmount)
                                    cell.coinTotalPrice.text = "("+String(total)+")"
                                    cell.profitChange.text = String(total - object.TransactionPrice)
                                    let profit:Float = total - object.TransactionPrice
                                    self.totalProfit = self.totalProfit + profit
                                    self.totalPrice = self.totalPrice + total
                                    let percentProfit:Float = ((total - object.TransactionPrice) / object.TransactionPrice) * 100
                                    if self.displayType == "Percent"{
                                        cell.checkRiseandfallPercent(risefallnumber: String(format: "%.2f", percentProfit))
                                    } else if self.displayType == "Number"{
                                        cell.checkRiseandfallNumber(risefallnumber: String(format: "%.1f", profit))
                                    }
                                    self.totalNumber.text = self.priceType + "$" + String(self.totalPrice)
                                    self.checkRiseandfallNumber(risefallnumber: String(self.totalProfit))
                                }
                                
                            } else{
                                print("fail")
                            }
                        }
                    }
                }
            case .failure(let error):
                print("the error \(error.localizedDescription)")
            }
        }



        cell.coinImage.coinImageSetter(coinName: object.coinAbbName, width: 30, height: 30, fontSize: 5)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            let cell:WalletsCell = walletList.cellForRow(at: indexPath) as! WalletsCell
            let filterName = "coinName = '" + cell.coinName.text! + "' "
            let statusItem = realm.objects(AllTransactions.self).filter(filterName)
            try! realm.write {
                realm.delete(statusItem)
            }
            self.totalPrice = 0
            self.totalProfit = 0
            self.walletResults = self.setWalletData()
            tableView.reloadData()
        }
    }

    @objc func changetotransaction(){
        cryptoCompareClient.getCoinList(){result in
            switch result{
            case .success(let resultData):
                guard let coinList = resultData?.Data else {return}
                for (_,value) in coinList{
                    try! self.container.write { transaction in
                        transaction.add(value, update: true)
                    }
                }
            case .failure(let error):
                print("the error \(error.localizedDescription)")
            }
        }
        let transaction = TransactionsController()
        self.navigationController?.pushViewController(transaction, animated: true)
    }

    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.totalPrice = 0
        self.totalProfit = 0
        self.walletList.reloadData()
        self.refresher.endRefreshing()
    }

    func setWalletData() -> [WalletDetail]{
        var wallets = [WalletDetail]()
        var list = [String]()

        for value in allResult{
            if list.contains(value.coinName){
                let indexs = wallets.index(where: { (item) -> Bool in
                    item.coinName == value.coinName
                })
                wallets[indexs!].tradingPairsName = value.tradingPairsName
                wallets[indexs!].exchangeName = value.exchangName
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

    func setupView(){
        view.backgroundColor = color.themeColor()

        //NavigationBar
        navigationController?.navigationBar.barTintColor =  color.themeColor()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        let titilebarlogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        titilebarlogo.image = image.logoImage()
        titilebarlogo.contentMode = .scaleAspectFit
        navigationItem.titleView = titilebarlogo

        //Add Subview
        totalProfitView.addSubview(totalLabel)
        totalProfitView.addSubview(totalNumber)
        totalProfitView.addSubview(totalChange)
        buttonView.addSubview(addTransactionButton)
        view.addSubview(totalProfitView)
        view.addSubview(buttonView)
        view.addSubview(walletList)
        walletList.addSubview(self.refresher)

        //Total Profit View Constraints(总资产)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":totalProfitView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v0(150)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":totalProfitView]))

        NSLayoutConstraint(item: totalLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: totalProfitView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: totalNumber, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: totalProfitView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: totalNumber, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: totalProfitView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: totalChange, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: totalProfitView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0).isActive = true

        totalProfitView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1]-10-[v2]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1":totalLabel,"v2":totalNumber,"v3":totalChange]))
        totalProfitView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v2]-10-[v3]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1":totalLabel,"v2":totalNumber,"v3":totalChange]))

        //Add Transaction Button Constraints
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v4]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":totalProfitView,"v4":buttonView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v4(60)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":totalProfitView,"v4":buttonView]))
        NSLayoutConstraint(item: addTransactionButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: buttonView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: addTransactionButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: buttonView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        buttonView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v5(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v5":addTransactionButton]))
        buttonView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v5(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v5":addTransactionButton]))

        //Wallet List Constraints
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v6]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v4":buttonView,"v6":walletList]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v4]-[v6]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v4":buttonView,"v6":walletList]))

    }

    lazy var totalProfitView:UIView = {
        var view = UIView()
        view.backgroundColor = color.walletCellcolor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var totalLabel:UILabel = {
        var label = UILabel()
        label.text = "总资产"
        label.font = label.font.withSize(20)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var totalNumber:UILabel = {
        var label = UILabel()
        label.text = "--"
        label.font = label.font.withSize(30)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var totalChange:UILabel = {
        var label = UILabel()
        label.text = "--"
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var buttonView:UIView = {
        var view = UIView()
        view.backgroundColor = color.themeColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var addTransactionButton:UIButton = {
        var button = UIButton()
        button.setTitle("➕", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(25)
        button.tintColor = UIColor.black
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changetotransaction), for: .touchUpInside)
        return button
    }()

    lazy var walletList:UITableView = {
        var collectionView = UITableView()
        collectionView.separatorStyle = .none
        collectionView.backgroundColor = color.themeColor()
        collectionView.register(WalletsCell.self, forCellReuseIdentifier: "WalletCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func checkRiseandfallNumber(risefallnumber: String) {
        if risefallnumber.prefix(1) == "-" {
            // lost with red
            totalChange.textColor = color.fallColor()
            totalChange.text = "▼ " + risefallnumber
        } else if risefallnumber == "0.00"{
            // Not any change with white
            totalChange.text = "--"
            totalChange.textColor = UIColor.white
        } else {
            //Profit with green
            totalChange.textColor = color.riseColor()
            totalChange.text = "▲ " + "+" + risefallnumber
        }
    }
}


