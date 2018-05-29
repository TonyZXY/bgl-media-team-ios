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
    var globalMarketData = GlobalMarket()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        loadData()
        refreshData()
        NotificationCenter.default.addObserver(self, selector: #selector(setPriceChange), name: NSNotification.Name(rawValue: "setPriceChange"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "setPriceChange"), object: nil)
    }
    
    @objc func loadData(){
        let generalPage = coinDetailController.gerneralController
        let filterName = "coinAbbName = '" + coinDetails.selectCoinAbbName + "' "
        let selectItem = realm.objects(MarketTradingPairs.self).filter(filterName)
        for value in selectItem{
            allLossView.profitLoss.text = scientificMethod(number:value.totalRiseFall)
            mainView.portfolioResult.text = scientificMethod(number:value.coinAmount) + " " + value.coinAbbName
            mainView.marketValueRsult.text = "A$"+scientificMethod(number:value.totalPrice)
            mainView.netCostResult.text =  "A$"+scientificMethod(number:value.transactionPrice)
            generalPage.mainView.totalNumber.text = "A$"+scientificMethod(number:value.singlePrice)
            generalPage.mainView.tradingPairs.text = value.tradingPairsName
            generalPage.mainView.market.text = value.exchangeName
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
            generalPage.coinSymbol = value.coinAbbName
            coinDetailController.transactionHistoryController.generalData = general
            
            generalPage.mainView.marketCapResult.text = String(globalMarketData.market_cap!)
            generalPage.mainView.volumeResult.text = String(globalMarketData.volume_24h!)
            generalPage.mainView.circulatingSupplyResult.text = String(globalMarketData.circulating_supply!)
            
//            let candleData = coinDetailController.gerneralController.vc
////            print(candleData.priceChange)
////            generalPage.mainView.totalRiseFall.text = String(candleData.priceChange)
        }
    }
    
    @objc func refreshData(){
        loadCoinPrice { (success) in
            if success{
                let coinNameId = self.getCoinName(coinAbbName: self.coinDetails.selectCoinAbbName)
                if coinNameId != 0 {
                    GetDataResult().getMarketCapCoinDetail(coinId: coinNameId, priceType: "AUD"){(globalMarket,bool) in
                        if bool {
                            DispatchQueue.main.async {
                                self.globalMarketData = globalMarket!
                                self.loadData()
                                self.coinDetailController.gerneralController.mainView.spinner.stopAnimating()
                            }
                        } else {
                            self.coinDetailController.gerneralController.mainView.spinner.stopAnimating()
                        }
                    }
                }
            } else{
                self.coinDetailController.gerneralController.mainView.spinner.stopAnimating()
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
                }
            } else{
                    self.coinDetailController.gerneralController.mainView.spinner.stopAnimating()
                print("fail")
            }
        }
    }
    
    func loadCoinPrice(completion:@escaping (Bool)->Void){
        coinDetailController.gerneralController.mainView.spinner.startAnimating()
        let filterName = "coinAbbName = '" + coinDetails.selectCoinAbbName + "' "
        
        let selectItem = realm.objects(MarketTradingPairs.self).filter(filterName)
        var tradingPairs:String = ""
        var exchangeName:String = ""
        for value in selectItem{
            exchangeName = value.exchangeName
            tradingPairs = value.tradingPairsName
            print(exchangeName)
        }
        
        marketSelectedData.exchangeName = exchangeName
        marketSelectedData.tradingPairsName = tradingPairs
        
        cryptoCompareClient.getTradePrice(from: marketSelectedData.coinAbbName, to: tradingPairs, exchange: exchangeName){ result in
            switch result{
            case .success(let resultData):
                for results in resultData!{
                    let single = Double(results.value)
                    self.getAllData(priceType: "AUD", walletData:self.marketSelectedData, single: single, eachCell: WalletsCell(), transactionPrice: self.marketSelectedData.transactionPrice)
                    completion(true)
                }
            case .failure(let error):
                print("the error \(error.localizedDescription)")
            }
        }
    }
    
    var spinner:UIActivityIndicatorView{
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
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
        refreshData()
        self.tabBarController?.tabBar.isHidden = true
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "reloadDetail"), object: nil)
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
    
    func getCoinName(coinAbbName:String)->Int{
        let data = GetDataResult().getMarketCapCoinList()
        var coinId:Int = 0
        print(data)

        for value in data {
            if value.symbol == coinAbbName{
                    coinId = value.id!
        }
        }
        if coinId == 0{
            self.coinDetailController.gerneralController.mainView.spinner.stopAnimating()
            let generalPage = coinDetailController.gerneralController
            generalPage.mainView.marketCapResult.text = "--"
            generalPage.mainView.volumeResult.text = "--"
            generalPage.mainView.circulatingSupplyResult.text = "--"
        }
        return coinId
    }
    
    @objc func setPriceChange() {
        let candleData = coinDetailController.gerneralController.vc
        coinDetailController.gerneralController.mainView.totalRiseFall.text = scientificMethod(number: candleData.priceChange!) + "(" + scientificMethod(number: candleData.priceChangeRatio!) + "%" + ")"
        
    }
    

}
