//
//  WalletListController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 19/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class WalletListController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    //Section 1 title bar view
    
    
    //Section 2 总资产view
    @IBOutlet weak var totalPriceView: UIView!
    
    //Section 3 add transaction button view
    @IBOutlet weak var addbuttonView: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    //Section 4 WalletTableview
    @IBOutlet weak var walletTableview: UITableView!
    
    
//    @IBOutlet weak var titleBar: UINavigationBar!
//    @IBOutlet weak var barLogo: UIImageView!
    
    @IBOutlet weak var totalUpDown: UIImageView!
    
    var color = ThemeColor()
    var image = AppImage()
    
    var test = ["-13","+12","+15","-1","-3","-3","+2","+3"]
    
    let logoimage = UIImage(named: "bcg_logo.png")
    let upimage = UIImage(named:"up.png")
    let downimage = UIImage(named:"down.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        barLogo.image = logoimage
//        titleBar.barTintColor = UIColor.init(red:47/255.0, green:49/255.0, blue:54/255.0, alpha:1)
        totalPriceView.backgroundColor = color.themeColor()
        totalPriceView.layer.borderColor = UIColor.white.cgColor
        totalPriceView.layer.borderWidth = CGFloat((Float(1.0)))
        
        addbuttonView.backgroundColor = color.themeColor()
        walletTableview.backgroundColor = color.themeColor()
        view.backgroundColor = color.themeColor()
        
        addButton.layer.cornerRadius = 20

        addButton.titleLabel?.sizeToFit()
        print(addButton.titleLabel?.frame.height)
        
//addButton.titleLabel.
//        addButton.titleEdgeInsets = UIEdgeInsetsMake((addButton.frame.height - (addButton.titleLabel?.frame.height)!)/2, -(addButton.frame.width - (addButton.titleLabel?.frame.width)!)/2, (addButton.frame.height - (addButton.titleLabel?.frame.height)!)/2, -(addButton.frame.width - (addButton.titleLabel?.frame.width)!)/2);

        
        addButton.titleEdgeInsets = UIEdgeInsetsMake(0,0,0,0);
        
//        addButton.titleLabel?.textAlignment = NSTextAlignment.justified
//        addButton.titleLabel?.textAlignment = NSTextAlignment.center
        addButton.backgroundColor = UIColor.white
        addButton.setTitleColor(UIColor.black, for: .normal)
        
        navigationController?.navigationBar.barTintColor =  color.themeColor()
        navigationController?.navigationBar.isTranslucent = false
        
        let titilebarlogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        titilebarlogo.image = image.logoImage()
        titilebarlogo.contentMode = .scaleAspectFit
        navigationItem.titleView = titilebarlogo
        
//        navigationController?.navigationBar.backgroundColor = UIColor.green
        DispatchQueue.main.async {
            self.walletTableview.separatorStyle = .none
            self.walletTableview.reloadData()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WalletListCell") as? WalletListCell else{
            return UITableViewCell()
        }

        //Automatically fit the cell
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
        //Read data to view
        cell.coinType.text = test[indexPath.row]
        cell.coinNumber.text = test[indexPath.row]
        cell.coinProfit.text = test[indexPath.row]
        cell.coinPrice.text = test[indexPath.row]
        
        //check price rise or fall
        cell.checkRiseandfall(risefallnumber: cell.coinProfit.text!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            test.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.hahahahaha
    }
    
}
