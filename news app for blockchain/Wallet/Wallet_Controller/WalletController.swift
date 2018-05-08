//
//  WalletController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 3/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON

class WalletController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var color = ThemeColor()
    var image = AppImage()
    let realm = try! Realm()
    var results = try! Realm().objects(Wallet.self)
    let cryptoCompareClient = CryptoCompareClient()
    var activityIndicator = UIActivityIndicatorView()
    let container = try! Container()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let statusItem = realm.objects(Wallet.self)
        writeJsonExchange()
        print(statusItem)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        DispatchQueue.main.async {
            self.walletList.reloadData()
        }
    }
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //        results = try! Realm().objects(Wallet.self)
        //        self.walletList.reloadData()
        self.refresher.endRefreshing()
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
        label.text = "A$123456"
        label.font = label.font.withSize(30)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var totalChange:UILabel = {
        var label = UILabel()
        label.text = "▼ -12,345.8"
        label.font = label.font.withSize(20)
        label.textColor = UIColor.red
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletCell", for: indexPath) as! WalletsCell
        let object = results[indexPath.row]
        var single:String = ""
        cryptoCompareClient.getTradePrice(from: object.coinAbbName, to: object.tradingPairsName, exchange: object.exchangName){ result in
            switch result{
            case .success(let resultData):
                for(_, value) in resultData!{
                    single = String(value)
                    cell.coinSinglePrice.text = single
                    let currentTotalPrice:Float = (Float(single)! * Float(object.coinAmount))
                    let purchaseTotalPrice:Float = object.totalPrice
                    cell.coinTotalPrice.text = "("+String(currentTotalPrice)+")"
                    let riseFall = String(format: "%.2f", (((currentTotalPrice - purchaseTotalPrice) / purchaseTotalPrice) * 100.0))
                    cell.checkRiseandfall(risefallnumber: riseFall)
                }
            case .failure(let error):
                print("the error \(error.localizedDescription)")
            }
        }
        cell.coinName.text = object.coinName
        cell.profitChange.text = object.priceChange
        cell.coinAmount.text = String(object.coinAmount) + object.coinAbbName
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            let cell:WalletsCell = walletList.cellForRow(at: indexPath) as! WalletsCell
            let filterName = "coinName = '" + cell.coinName.text! + "' "
            let statusItem = realm.objects(Wallet.self).filter(filterName)
            try! realm.write {
                realm.delete(statusItem)
            }
            tableView.reloadData()
        }
    }
    
    @objc func changetotransaction(){
        coinNameSelect = ""
        coinAbbNameSelect = ""
        exchangesNameSelect = ""
        tradingPairsNameSelect = ""
        tradingPairsAll.removeAll()
        transactionExpense = ""
        let transactions = TransactionsController()
        
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
        self.navigationController?.pushViewController(transactions, animated: true)
    }
    
    //    func getCoinList(completion: @escaping (Result<CryptoCompareCoinListResult?, APIError>) -> Void){
    //        let endpoint = CryptoCompareEndpoint(type: CryptoComparePath.coinlist)
    //        let request = endpoint.request
    //
    //        fetch(with: request, decode:{ json -> CryptoCompareCoinListResult? in
    //            guard let coinListResult = json as? CryptoCompareCoinListResult else {return nil}
    //            return coinListResult
    //        }, completion: completion)
    //    }
    //
    func writeJsonExchange(){
        Alamofire.request("https://min-api.cryptocompare.com/data/all/exchanges", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentsURL.appendingPathComponent("Exchanges.json")
                let json = JSON(value)
                do {
                    let rawData = try json.rawData()
                    try rawData.write(to: fileURL, options: .atomic)
                } catch {
                    print("Error \(error)")
                    print("save data")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
