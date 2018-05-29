//
//  GloabalController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 23/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift
class GloabalController: UIViewController {
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
        getCoinGloablDetail()
        NotificationCenter.default.addObserver(self, selector: #selector(setPriceChange), name: NSNotification.Name(rawValue: "setPriceChange"), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "setPriceChange"), object: nil)
    }
    
    func setUpView(){
        addChildViewControllers(childViewControllers: coinDetailController, views: view)
        let titleLabel = UILabel()
        titleLabel.text = coinDetail.coinName
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
    }
    
    @objc func loadData(){
        let generalPage = coinDetailController.gerneralController
        generalPage.mainView.edit.isHidden = true
        generalPage.mainView.tradingPairs.text = coinDetail.coinName + "/" + "AUD"
        generalPage.mainView.market.text = "Global average"
        generalPage.mainView.marketCapResult.text = "A$" + scientificMethod(number: globalMarketData.market_cap!)
        generalPage.mainView.volumeResult.text = "A$" + scientificMethod(number: globalMarketData.volume_24h!)
        generalPage.mainView.circulatingSupplyResult.text = scientificMethod(number: globalMarketData.circulating_supply!)
        generalPage.coinSymbol = coinDetail.coinName
        general.coinAbbName = coinDetail.coinName
        coinDetailController.transactionHistoryController.generalData = general
        generalPage.mainView.totalNumber.text = "A$"+scientificMethod(number:globalMarketData.price!)
        
//        generalPage
        
//        let filterName = "coinAbbName = '" + general.coinAbbName + "' "
//        let selectItem = realm.objects(MarketTradingPairs.self).filter(filterName)
//        for value in selectItem{
//            generalPage.mainView.totalNumber.text = "hah"
//
//
////            generalPage.mainView.totalNumber.text = "A$"+scientificMethod(number:value.singlePrice)
//            generalPage.mainView.tradingPairs.text = value.tradingPairsName
//            generalPage.mainView.market.text = value.exchangeName
//            general.coinAbbName = value.coinAbbName
//            general.coinName = value.coinName
//            general.exchangeName = value.exchangeName
//            general.tradingPairs = value.tradingPairsName
//            marketSelectedData.coinAbbName = value.coinAbbName
//            marketSelectedData.coinName = value.coinName
//            marketSelectedData.exchangeName = value.exchangeName
//            marketSelectedData.tradingPairsName = value.tradingPairsName
//            marketSelectedData.transactionPrice = value.transactionPrice
//            marketSelectedData.coinAmount = value.coinAmount
//            generalPage.coinSymbol = value.coinAbbName
//            coinDetailController.transactionHistoryController.generalData = general
//
//            generalPage.mainView.marketCapResult.text = String(globalMarketData.market_cap!)
//            generalPage.mainView.volumeResult.text = String(globalMarketData.volume_24h!)
//            generalPage.mainView.circulatingSupplyResult.text = String(globalMarketData.circulating_supply!)
//
//            //            let candleData = coinDetailController.gerneralController.vc
//            ////            print(candleData.priceChange)
//            ////            generalPage.mainView.totalRiseFall.text = String(candleData.priceChange)
//        }
        
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
    
    func getCoinGloablDetail(){
        let coinNameId = self.getCoinName(coinAbbName: coinDetail.coinName)
        print(coinNameId)
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
    }
    
    func getCoinName(coinAbbName:String)->Int{
        let data = GetDataResult().getMarketCapCoinList()
        var coinId:Int = 0
        
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
        coinDetailController.gerneralController.mainView.totalRiseFall.text = scientificMethod(number: candleData.priceChange!)
    }

}
