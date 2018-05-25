//
//  MoreOptionsRootViewController.swift
//  news app for blockchain
//
//  Created by Rock on 25/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class MoreOptionsRootViewController: UIViewController, UISplitViewControllerDelegate{
    
    let mainSplitView: UISplitViewController = UISplitViewController()
    let masterViewController: UINavigationController = UINavigationController(rootViewController: MasterViewController())
    let detailViewController: UINavigationController = UINavigationController(rootViewController: AboutUsDetailViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mainSplitView.viewControllers = [masterViewController,detailViewController]
        self.view.addSubview(mainSplitView.view)
        mainSplitView.delegate = self
        mainSplitView.preferredDisplayMode = .automatic
    }
    
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //        splitViewController?.delegate = self
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        // Return true to prevent UIKit from applying its default behavior
        return true
    }
    
}

//extension UIView {
//    func addConstraintsWithFormat(format: String, views: UIView...){
//        var viewsDictionary = [String:UIView]()
//        for (index,view) in views.enumerated() {
//            let key = "v\(index)"
//            view.translatesAutoresizingMaskIntoConstraints = false
//            viewsDictionary[key] = view
//        }
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
//    }
//}

