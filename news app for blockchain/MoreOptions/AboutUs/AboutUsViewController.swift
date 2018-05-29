//
//  AboutUsViewController.swift
//  news app for blockchain
//
//  Created by Rock on 21/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let label00 = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        label00.textAlignment = .center
        label00.textColor = UIColor.white
        label00.text = "关于Blockchain Global"
        self.navigationItem.titleView = label00
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
