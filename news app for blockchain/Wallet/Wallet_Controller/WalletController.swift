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
    var all = try! Realm().objects(MarketTradingPairs.self)
    let cryptoCompareClient = CryptoCompareClient()
    var activityIndicator = UIActivityIndicatorView()
    let container = try! Container()
    var walletResults = [WalletDetail]()
    var displayType:String = "Percent"
    let priceType:String = "AUD"
    var refreshTimer: Timer!
    var coinDetail = SelectCoin()
    var profitPrice:Double = 0
    var profitPercent:Double = 0
    var price:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        SetDataResult().writeJsonExchange()
        SetDataResult().writeMarketCapCoinList()
        GetDataResult().getCoinList()
        refreshTimer = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(reloadWalletData), userInfo: nil, repeats: true)
        print(allResult)
        print(all)
        refreshData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "reloadWallet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadWalletData), name: NSNotification.Name(rawValue: "reloadWallet"), object: nil)
    }
    
    func getAllData(priceType:String,walletData:MarketTradingPairs,single:Double,eachCell:WalletsCell,transactionPrice:Double){
        GetDataResult().getCryptoCurrencyApi(from: walletData.tradingPairsName, to: priceType, price: single){success,price in
            if success{
                DispatchQueue.main.async {
                    walletData.singlePrice = price
                    walletData.totalPrice = Double(price) * Double(walletData.coinAmount)
                    walletData.totalRiseFallPercent = ((walletData.totalPrice - transactionPrice) / transactionPrice) * 100
                    walletData.totalRiseFall = walletData.totalPrice - transactionPrice
                    
                    self.realm.beginWrite()
                    if self.realm.object(ofType: MarketTradingPairs.self, forPrimaryKey: walletData.coinAbbName) == nil {
                        self.realm.create(MarketTradingPairs.self,value:[walletData.coinName,walletData.coinAbbName,walletData.exchangeName,walletData.tradingPairsName,walletData.coinAmount,walletData.totalRiseFall,walletData.singlePrice,walletData.totalPrice,walletData.totalRiseFallPercent,walletData.transactionPrice,walletData.priceType])
                    } else {
                        self.realm.create(MarketTradingPairs.self,value:[walletData.coinName,walletData.coinAbbName,walletData.exchangeName,walletData.tradingPairsName,walletData.coinAmount,walletData.totalRiseFall,walletData.singlePrice,walletData.totalPrice,walletData.totalRiseFallPercent,walletData.transactionPrice,walletData.priceType],update:true)
                    }
                    try! self.realm.commitWrite()
                }
            } else{
                print("fail")
            }
        }
    }
    
    
    func refreshData() {
        self.refresher.beginRefreshing()
        setWalletData()
        refreshAllData()
    }
    
    @objc func reloadWalletData() {
        refreshData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletCell", for: indexPath) as! WalletsCell
        let object = all[indexPath.row]
        cell.coinName.text = object.coinName
        cell.coinAmount.text = String(object.coinAmount) + object.coinAbbName
        cell.coinSinglePrice.text = self.scientificMethod(number:object.singlePrice)
        cell.coinTotalPrice.text = "("+self.scientificMethod(number: object.totalPrice)+")"
        cell.selectCoin.selectCoinAbbName = object.coinAbbName
        cell.selectCoin.selectCoinName = object.coinName
        cell.selectCoin.selectExchangeName = object.exchangeName
        cell.selectCoin.selectTradingPairs = object.tradingPairsName
        cell.coinImage.coinImageSetter(coinName: object.coinAbbName, width: 30, height: 30, fontSize: 5)
        if self.displayType == "Percent"{
            cell.checkRiseandfallPercent(risefallnumber: object.totalRiseFallPercent)
        } else if self.displayType == "Number"{
            cell.checkRiseandfallNumber(risefallnumber: object.totalRiseFall)
        }
        
        if self.displayType == "Percent"{
            self.checkRiseandfallPercent(risefallnumber: self.profitPercent)
        } else if self.displayType == "Number"{
            self.checkRiseandfallNumber(risefallnumber: self.profitPrice)
        }
        self.totalNumber.text = self.priceType + "$" + self.scientificMethod(number: self.price)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailPage = DetailController()
        let cell = self.walletList.cellForRow(at: indexPath) as! WalletsCell
        coinDetail = cell.selectCoin
        detailPage.coinDetails = coinDetail
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadDetail"), object: nil)
        navigationController?.pushViewController(detailPage, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            let cell:WalletsCell = walletList.cellForRow(at: indexPath) as! WalletsCell
            let filterName = "coinName = '" + cell.coinName.text! + "' "
            let statusItem = realm.objects(AllTransactions.self).filter(filterName)
            let status = realm.objects(MarketTradingPairs.self).filter(filterName)
            
            try! realm.write {
                realm.delete(statusItem)
                realm.delete(status)
            }
            self.totalNumber.text = self.priceType + "$" + "-"
            self.checkRiseandfallNumber(risefallnumber: 0)
            refreshData()
        }
    }
    
    @objc func changetotransaction(){
        let transaction = TransactionsController()
        self.navigationController?.pushViewController(transaction, animated: true)
    }
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshData()
    }
    
    func refreshAllData(){
        loadCoinPrice { (success) in
            if success{
                DispatchQueue.main.async {
                    self.profitPrice = 0
                    self.profitPercent = 0
                    self.price = 0
                    let coinSelected = self.realm.objects(MarketTradingPairs.self)
                    var transactionPrice:Double = 0
                    for value in coinSelected{
                        self.price = self.price + value.totalPrice
                        self.profitPrice = self.profitPrice + value.totalRiseFall
                        transactionPrice = transactionPrice + value.transactionPrice
                    }
                    self.profitPercent = (self.profitPrice / transactionPrice) * 100
                    self.walletList.reloadData()
                    self.refresher.endRefreshing()
                }
            }
        }
    }
    
    func loadCoinPrice(completion:@escaping (Bool)->Void){
        let objects = self.walletResults
        print(String(objects.count) + "hahaha")
        let marketSelectedData = MarketTradingPairs()
        for object in objects{
            marketSelectedData.coinAbbName = object.coinAbbName
            marketSelectedData.coinName = object.coinName
            marketSelectedData.coinAmount = object.coinAmount
            let filterName = "coinAbbName = '" + object.coinAbbName + "' "
            let coinSelected = realm.objects(MarketTradingPairs.self).filter(filterName)
            
            if coinSelected.count == 0{
                marketSelectedData.exchangeName = object.exchangeName
                marketSelectedData.tradingPairsName = object.tradingPairsName
            } else {
                for value in coinSelected{
                    marketSelectedData.exchangeName = value.exchangeName
                    marketSelectedData.tradingPairsName = value.tradingPairsName
                }
            }
            marketSelectedData.priceType = priceType
            marketSelectedData.transactionPrice = object.TransactionPrice
            
            cryptoCompareClient.getTradePrice(from: marketSelectedData.coinAbbName, to: marketSelectedData.tradingPairsName, exchange: marketSelectedData.exchangeName){ result in
                switch result{
                case .success(let resultData):
                    for results in resultData!{
                        let single = Double(results.value)
                        self.getAllData(priceType: self.priceType, walletData:marketSelectedData, single: single, eachCell: WalletsCell(), transactionPrice: object.TransactionPrice)
                    }
                case .failure(let error):
                    print("the error \(error.localizedDescription)")
                }
            }
        }
        completion(true)
    }
    
    
    func setWalletData(){
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
        walletResults = wallets
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
        view.addSubview(filterButtonNumber)
        view.addSubview(filterButtonPercent)
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
        
        //Add filter Button Constraints
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v7(100)]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v4":buttonView,"v7":filterButtonNumber]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v4]-10-[v7(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v4":buttonView,"v7":filterButtonNumber]))
        
        //Add filter Button Constraints
        NSLayoutConstraint(item: filterButtonNumber, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: filterButtonPercent, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v8(100)]-10-[v7]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v8":filterButtonPercent,"v7":filterButtonNumber]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v8(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v8":filterButtonPercent,"v7":filterButtonNumber]))
        
        
        //Wallet List Constraints
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v6]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v7":filterButtonNumber,"v6":walletList]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v7]-10-[v6]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v7":filterButtonNumber,"v6":walletList]))
        
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
    
    var filterButtonNumber:UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("总数", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 80)
        button.titleLabel?.font = button.titleLabel?.font.withSize(15)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = ThemeColor().walletCellcolor()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(setUpNumber), for: .touchUpInside)
        return button
    }()
    
    var filterButtonPercent:UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("涨幅", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(15)
        button.setTitleColor(ThemeColor().themeColor(), for: .normal)
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(setUpPercent), for: .touchUpInside)
        return button
    }()
    
    @objc func setUpNumber(){
        displayType = "Number"
        filterButtonNumber.setTitleColor(ThemeColor().themeColor(), for: .normal)
        filterButtonNumber.backgroundColor = UIColor.white
        filterButtonPercent.setTitleColor(UIColor.white, for: .normal)
        filterButtonPercent.backgroundColor = ThemeColor().walletCellcolor()
        walletList.reloadData()
    }
    
    @objc func setUpPercent(){
        displayType = "Percent"
        filterButtonPercent.setTitleColor(ThemeColor().themeColor(), for: .normal)
        filterButtonPercent.backgroundColor = UIColor.white
        filterButtonNumber.setTitleColor(UIColor.white, for: .normal)
        filterButtonNumber.backgroundColor = ThemeColor().walletCellcolor()
        walletList.reloadData()
    }
    
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
    
    func checkRiseandfallNumber(risefallnumber: Double) {
        if String(risefallnumber).prefix(1) == "-" {
            // lost with red
            totalChange.textColor = color.fallColor()
            totalChange.text = "▼ " + scientificMethod(number: risefallnumber)
        } else if String(risefallnumber) == "0.0"{
            // Not any change with white
            totalChange.text = "--"
            totalChange.textColor = UIColor.white
        } else {
            //Profit with green
            totalChange.textColor = color.riseColor()
            totalChange.text = "▲ " + "+" + scientificMethod(number: risefallnumber)
        }
    }
    
    func checkRiseandfallPercent(risefallnumber: Double) {
        if String(risefallnumber).prefix(1) == "-" {
            // lost with red
            totalChange.textColor = color.fallColor()
            totalChange.text = "▼ " + scientificMethod(number: risefallnumber) + "%"
        } else if String(risefallnumber) == "0.0"{
            // Not any change with white
            totalChange.text = "--"
            totalChange.textColor = UIColor.white
        } else {
            //Profit with green
            totalChange.textColor = color.riseColor()
            totalChange.text = "▲ " + "+" + scientificMethod(number: risefallnumber)  + "%"
        }
    }
    
    func getDoubleFrom(textField: UILabel) -> Double
    {
        var doubleValue : Double = 0.0
        
        if let val = textField.text
        {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            let finalNumber = numberFormatter.number(from: val)
            doubleValue = Double((finalNumber?.doubleValue)!);
        }
        
        return doubleValue
    }
    
    
    //    func getStringFrom(double doubleVal: Double) -> String
    //    {
    //        var stringValue : String = "0.00"
    //
    //        let formatter = NumberFormatter()
    //        formatter.usesSignificantDigits = true;
    //        formatter.maximumSignificantDigits = 100
    //        formatter.groupingSeparator = "";
    //        formatter.numberStyle = .decimal
    //        stringValue = formatter.stringFromNumber(Nsnumber(doubleVal))!;
    //
    //        return stringValue
    //    }
    
}



