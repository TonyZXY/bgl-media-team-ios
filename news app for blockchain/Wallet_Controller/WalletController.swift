//
//  WalletController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 3/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class WalletController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var color = ThemeColor()
    var image = AppImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupView(){
        view.backgroundColor = color.themeColor()
        
        //NavigationBar
        navigationController?.navigationBar.barTintColor =  color.themeColor()
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
        
        //Total Profit View Constraints(总资产)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":totalProfitView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(180)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":totalProfitView]))
        
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
    
    lazy var walletList:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout:layout)
        collectionView.backgroundColor = color.themeColor()
        collectionView.register(WalletCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    @objc func changetotransaction(){
        let transactions = TransactionsController()
        self.navigationController?.pushViewController(transactions, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:view.frame.width-10, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:view.frame.width, height: 10)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class WalletCell:UICollectionViewCell{
    var color = ThemeColor()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    func setupView(){
        addSubview(coinImage)
        addSubview(coinName)
        addSubview(profitChange)
        addSubview(coinAmount)
        addSubview(coinTotalPrice)
        addSubview(coinSinglePrice)
        
        self.backgroundColor = color.walletCellcolor()
        
        //CoinImage
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views:
            ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views:
            ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: coinImage, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
        
        //CoinName
         addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-5-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: coinName, attribute: .bottom, relatedBy: .equal, toItem: coinImage, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        //ProfitChange
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v2]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: profitChange, attribute: .centerY, relatedBy: .equal, toItem: coinName, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        //CoinAmount
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-5-[v3]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: coinAmount, attribute: .top, relatedBy: .equal, toItem: coinImage, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        //CoinTotalPrice
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v3]-5-[v4]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: coinTotalPrice, attribute: .centerY, relatedBy: .equal, toItem: coinAmount, attribute: .centerY, multiplier: 1, constant: 0).isActive = true

        //CoinTotalPrice
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v5]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage,"v1":coinName,"v2":profitChange,"v3":coinAmount,"v4":coinTotalPrice,"v5":coinSinglePrice]))
        NSLayoutConstraint(item: coinSinglePrice, attribute: .centerY, relatedBy: .equal, toItem: coinAmount, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        
    }
    
    let coinImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "navigation_arrow.png"))
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var coinName:UILabel = {
       var label = UILabel()
        label.text = "Bitcoin"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var profitChange:UILabel = {
        var label = UILabel()
        label.text = "Bitcoin"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var coinAmount:UILabel = {
        var label = UILabel()
        label.text = "Bitcoin"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var coinTotalPrice:UILabel = {
        var label = UILabel()
        label.text = "Bitcoin"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var coinSinglePrice:UILabel = {
        var label = UILabel()
        label.text = "Bitcoin"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init Error")
    }
}
