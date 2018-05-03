//
//  WalletListController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 19/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    //Section 1 title bar view
    
    
    //Section 2 总资产view
    @IBOutlet weak var totalPriceView: UIView!
    
    //Section 3 add transaction button view
    @IBOutlet weak var addbuttonView: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    //Section 4 WalletTableview
    @IBOutlet weak var walletTableview: UITableView!
    
    

    
    @IBOutlet weak var totalUpDown: UIImageView!
    
    var test = ["-13","+12","+15","-1","-3","-3","+2","+3"]
    let logoimage = UIImage(named: "bcg_logo.png")
    let upimage = UIImage(named:"up.png")
    let downimage = UIImage(named:"down.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalPriceView.backgroundColor = UIColor.init(red:47/255.0, green:49/255.0, blue:54/255.0, alpha:1)
        totalPriceView.layer.borderColor = UIColor.white.cgColor
        totalPriceView.layer.borderWidth = CGFloat((Float(1.0)))
        addbuttonView.backgroundColor = UIColor.init(red:47/255.0, green:49/255.0, blue:54/255.0, alpha:1)
        walletTableview.backgroundColor = UIColor.init(red:47/255.0, green:49/255.0, blue:54/255.0, alpha:1)
        
        addButton.layer.cornerRadius = 20
        addButton.titleLabel?.textAlignment = NSTextAlignment.justified
        addButton.titleLabel?.textAlignment = NSTextAlignment.center
        addButton.backgroundColor = UIColor.white
        addButton.setTitleColor(UIColor.black, for: .normal)
        
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
        
        //Change the radius of the tableview cell
        cell.backgroundColor = UIColor.init(red:54/255.0, green:57/255.0, blue:62/255.0, alpha:1)
        cell.layer.cornerRadius =  cell.walletCell.frame.height/4
        cell.walletCell.layer.cornerRadius =  cell.walletCell.frame.height/4
        cell.walletCell.backgroundColor = UIColor.init(red:47/255.0, green:49/255.0, blue:54/255.0, alpha:1)
        cell.walletCell.layer.borderColor = UIColor.white.cgColor
        cell.walletCell.layer.borderWidth = CGFloat((Float(1.0)))
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
        //Read data to view
        cell.coinType.text = test[indexPath.row]
        cell.coinNumber.text = test[indexPath.row]
        cell.coinProfit.text = test[indexPath.row]
        cell.coinPrice.text = test[indexPath.row]
        
        
        //Change the color of price according profit or loss
        cell.coinPrice.textColor = UIColor.white
        if cell.coinProfit.text?.prefix(1) == "+" {
            //Profit with green
            cell.coinProfit.textColor = UIColor.init(red:37/255.0, green:155/255.0, blue:36/255.0, alpha:1)
            cell.coinProfit.text = "▲ " + cell.coinProfit.text!
        }else if cell.coinProfit.text?.prefix(1) == "-" {
            // lost with red
            cell.coinProfit.textColor = UIColor.init(red:229.0/255.0, green:28.0/255.0, blue:35.0/255.0, alpha:1)
            cell.coinProfit.text = "▼ " + cell.coinProfit.text!
        } else{
            // Not any change with white
            cell.coinProfit.textColor = UIColor.white
        }
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
