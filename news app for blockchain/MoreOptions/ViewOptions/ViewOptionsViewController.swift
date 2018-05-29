//
//  ViewOptionsViewController.swift
//  news app for blockchain
//
//  Created by Rock on 21/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class ViewOptionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let label12 = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        label12.textAlignment = .center
        label12.textColor = UIColor.white
        label12.text = "界面显示选项"
        self.navigationItem.titleView = label12
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
