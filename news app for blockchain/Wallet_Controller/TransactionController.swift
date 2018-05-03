//
//  TransactionController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 29/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class TransactionController: UIViewController {
    var color = ThemeColor()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.navigationBar.barTintColor =  color.themeColor()
        navigationController?.navigationBar.isTranslucent = false

        let titleLabel = UILabel()
        titleLabel.text = "Blockchain Global"
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        
//        navigationItem.title = "Blockchain Global"
//        navigationController?.navigationBar.titleTextAttributes =  [NSAttributedStringKey.foregroundColor: UIColor.white]
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
