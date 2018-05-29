//
//  GerneralController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 21/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift
class GerneralController: UIViewController {
    var observer:NSObjectProtocol?
    let mainView = GeneralView()
    var generalData = generalDetail()
    let realm = try! Realm()
    let vc = CandleStickChartViewController()
    var coinSymbol:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView(){
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: mainView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: mainView)
        
        vc.willMove(toParentViewController: self)
        mainView.ImageView.addSubview(vc.view)
        self.addChildViewController(vc)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.frame.size.height = mainView.ImageView.frame.size.height
//        vc.view.frame.size.width = mainView.ImageView.frame.size.width

        NSLayoutConstraint(item: vc.view, attribute: .centerX, relatedBy: .equal, toItem: mainView.ImageView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: vc.view, attribute: .centerY, relatedBy: .equal, toItem: mainView.ImageView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: vc.view, attribute: .width, relatedBy: .equal, toItem: mainView.ImageView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: vc.view, attribute: .height, relatedBy: .equal, toItem: mainView.ImageView, attribute: .height, multiplier: 1, constant: 0).isActive = true

        vc.coinSymbol = coinSymbol
        vc.didMove(toParentViewController: self)
    }
    
    func addChildViewControllers(childViewControllers:UIViewController,views:UIView){
        addChildViewController(childViewControllers)
        views.addSubview(childViewControllers.view)
        childViewControllers.view.frame = views.bounds
        childViewControllers.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        childViewControllers.didMove(toParentViewController: self)
        
        //Constraints
        childViewControllers.view.translatesAutoresizingMaskIntoConstraints = false
        childViewControllers.view.topAnchor.constraint(equalTo: views.topAnchor).isActive = true
        childViewControllers.view.leftAnchor.constraint(equalTo: views.leftAnchor).isActive = true
        childViewControllers.view.widthAnchor.constraint(equalTo: views.widthAnchor).isActive = true
        childViewControllers.view.heightAnchor.constraint(equalTo: views.heightAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
