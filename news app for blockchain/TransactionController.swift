//
//  TransactionController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 19/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class TransactionController: UIViewController {
    let logoimage = UIImageView(image: UIImage(named: "bcg_logo.png"))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        logoimage.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        logoimage.clipsToBounds = true
        logoimage.contentMode = UIViewContentMode.scaleAspectFit
        navigationItem.titleView = logoimage
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
