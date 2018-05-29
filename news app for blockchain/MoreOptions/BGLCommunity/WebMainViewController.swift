//
//  webmainViewController.swift
//  news app for blockchain
//
//  Created by Rock on 15/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class WebMainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(rootView)
        rootView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        rootView.addSubview(label)
        view.addConstraintsWithFormat(format: "H:|-100-[v0]", views: label)
        view.addConstraintsWithFormat(format: "V:|-100-[v0]", views: label)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let rootView: UIView = {
        let vi = UIView()
        vi.translatesAutoresizingMaskIntoConstraints = false
        vi.backgroundColor = .white
        return vi
    }()
    
    let label: UILabel = {
        let la = UILabel()
        la.text = "This is the community webview main menu"
        la.textAlignment = .center
        return la
    }()
    
    
}
