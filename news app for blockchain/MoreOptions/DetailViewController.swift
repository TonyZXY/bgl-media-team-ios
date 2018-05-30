//
//  DetailViewController.swift
//  news app for blockchain
//
//  Created by Rock on 25/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
//    var secIndex = [[Int]]()
//  call the view controllers of section 1
    var index0: Int? {
        didSet{
            if index0 == 0 {
                let vc = AboutUsDetailViewController()
                view.addSubview(vc.view)
            }
            if index0 == 1 {
                let vc = WebMainViewController()
                view.addSubview(vc.view)
                self.addChildViewController(vc)
            }
        }
    }

// call the view controllers of section 2 
    var index1: Int? {
        didSet{
            if index1 == 0 {
                let vc = DefaultCurrencyViewController()
                view.addSubview(vc.view)
                self.addChildViewController(vc)
            }
            if index1 == 1 {
                let vc = NotificationViewController()
                view.addSubview(vc.view)
                self.addChildViewController(vc)
            }
            if index1 == 2 {
                let vc = ViewOptionsViewController()
                view.addSubview(vc.view)
                self.addChildViewController(vc)
            }
            if index1 == 3 {
                let vc = OtherOptionViewController()
                view.addSubview(vc.view)
                self.addChildViewController(vc)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
