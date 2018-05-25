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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //         NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: "reloadDetail"), object: nil)
        //            loadData()
        //        DispatchQueue.main.async {
        //            self.loadData()
        //        }
//        setUpData()
    }
    
    
    func setUpView(){
        view.addSubview(mainView)
//        mainView.edit.addTarget(self, action: #selector(edit), for: .touchUpInside)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: mainView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: mainView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func getGlobalData(){
//        let marketCapClient = MarketCapClient()
//        marketCapClient.getGlobalCap(convert: "AUD"){ result in
//            switch result{
//            case .success(let resultData):
//                guard let globalCap = resultData else {return}
//
//            case .failure(let error):
//                print("the error \(error.localizedDescription)")
//            }
//        }
//
//    }
}
