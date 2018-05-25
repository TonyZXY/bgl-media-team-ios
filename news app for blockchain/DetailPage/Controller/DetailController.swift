//
//  DetailController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 18/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift

class generalDetail{
    var coinName:String = ""
    var coinAbbName:String = ""
    var totalNumber:Double = 0
    var exchangeName:String = ""
    var tradingPairs:String = ""
}

class DetailController: UIViewController{
    var menuitems = ["General","Transactions","Alerts"]
    let cryptoCompareClient = CryptoCompareClient()
    var coinDetail = CoinDetailData()
    var observer:NSObjectProtocol?
    var coinDetails = SelectCoin()
    let mainView = MainView()
    let allLossView = AllLossView()
    let realm = try! Realm()
    var coinData = try! Realm().objects(MarketTradingPairs.self)
    var detail = MarketTradingPairs()
    let coinDetailController = CoinDetailController()
    let general = generalDetail()
    var marketSelectedData = MarketTradingPairs()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        loadData()
    }
    

    
    @objc func loadData(){
        let generalPage = coinDetailController.gerneralController.mainView
        let filterName = "coinAbbName = '" + coinDetails.selectCoinAbbName + "' "
        let selectItem = realm.objects(MarketTradingPairs.self).filter(filterName)
        for value in selectItem{
            allLossView.profitLoss.text = scientificMethod(number:value.totalRiseFall)
            mainView.portfolioResult.text = scientificMethod(number:value.coinAmount) + " " + value.coinAbbName
            mainView.marketValueRsult.text = "A$"+scientificMethod(number:value.totalPrice)
            mainView.netCostResult.text =  "A$"+scientificMethod(number:value.transactionPrice)
            generalPage.totalNumber.text = "A$"+scientificMethod(number:value.singlePrice)
            generalPage.tradingPairs.text = value.tradingPairsName
            generalPage.market.text = value.exchangeName
            general.coinAbbName = value.coinAbbName
            general.coinName = value.coinName
            general.exchangeName = value.exchangeName
            general.tradingPairs = value.tradingPairsName
            marketSelectedData.coinAbbName = value.coinAbbName
            marketSelectedData.coinName = value.coinName
            marketSelectedData.exchangeName = value.exchangeName
            marketSelectedData.tradingPairsName = value.tradingPairsName
            marketSelectedData.transactionPrice = value.transactionPrice
            marketSelectedData.coinAmount = value.coinAmount
            coinDetailController.transactionHistoryController.generalData = general
        }
    }

    @objc func refreshData(){
        cryptoCompareClient.getTradePrice(from: marketSelectedData.coinAbbName, to: marketSelectedData.tradingPairsName, exchange: marketSelectedData.exchangeName){ result in
            switch result{
            case .success(let resultData):
                for results in resultData!{
                    let single = Double(results.value)
                    self.getAllData(priceType: "AUD", walletData:self.marketSelectedData, single: single, eachCell: WalletsCell(), transactionPrice: self.marketSelectedData.transactionPrice)
                }
            case .failure(let error):
                print("the error \(error.localizedDescription)")
            }
        }
        
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
                    print("success")
                    self.loadData()
                }
            } else{
                print("fail")
            }
        }
    }
    
    @objc func edit(){
        let market = MarketSelectController()
        market.newTransaction.coinAbbName = general.coinAbbName
        market.newTransaction.coinName = general.coinName
        market.newTransaction.exchangName = general.exchangeName
        market.newTransaction.tradingPairsName = general.tradingPairs
        navigationController?.pushViewController(market, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.loadData()
         NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: NSNotification.Name(rawValue: "reloadDetail"), object: nil)
    }

    func addChildViewControllers(childViewControllers:UIViewController,views:UIView){
        addChildViewController(childViewControllers)
        views.addSubview(childViewControllers.view)
        childViewControllers.view.frame = views.bounds
        childViewControllers.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        childViewControllers.didMove(toParentViewController: self)
        
        //Constraints
        childViewControllers.view.translatesAutoresizingMaskIntoConstraints = false
        childViewControllers.view.topAnchor.constraint(equalTo: views.topAnchor).isActive = true
        childViewControllers.view.leftAnchor.constraint(equalTo: views.leftAnchor).isActive = true
        childViewControllers.view.widthAnchor.constraint(equalTo: views.widthAnchor).isActive = true
        childViewControllers.view.heightAnchor.constraint(equalTo: views.heightAnchor).isActive = true
    }
    
    func setUpView(){
         coinDetailController.gerneralController.mainView.edit.addTarget(self, action: #selector(edit), for: .touchUpInside)
        view.backgroundColor = ThemeColor().themeColor()
        let titleLabel = UILabel()
        titleLabel.text = coinDetails.selectCoinName
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        
        view.addSubview(allLossView)
        view.addSubview(mainView)
        
        //AllLossView Constraint
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":allLossView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":allLossView]))
        
        //MainView Constraint
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":allLossView,"v1":mainView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-0-[v1(80)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":allLossView,"v1":mainView]))
        
        view.addSubview(coinDetailView)
        //coinDetailPage
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinDetailView,"v1":mainView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1]-0-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinDetailView,"v1":mainView]))
        addChildViewControllers(childViewControllers: coinDetailController, views: coinDetailView)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var coinDetailView:UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func getCoinData(CoinName:String){
//        coinDetail.coinName = "k"
        
    }

}