//
//  webmainViewController.swift
//  news app for blockchain
//
//  Created by Rock on 15/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class WebMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let data = ["Weibo","Wechat","Twitter","Facebook","Youtube"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        webTableView.dataSource = self
        webTableView.delegate = self
        navigationItem.titleView = titleLabel
        
        view.addSubview(webTableView)
        webTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
//        rootView.addSubview(label)
//        view.addConstraintsWithFormat(format: "H:|-100-[v0]", views: label)
//        view.addConstraintsWithFormat(format: "V:|-100-[v0]", views: label)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(data.count)
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.3294117647, green: 0.7019607843, blue: 0.6901960784, alpha: 0.8015839041)
        return cell
    }
    
//    let rootView: UIView = {
//        let vi = UIView()
//        vi.translatesAutoresizingMaskIntoConstraints = false
//        vi.backgroundColor = .white
//        return vi
//    }()
    
    let webTableView: UITableView = {
        let tbvi = UITableView()
        tbvi.translatesAutoresizingMaskIntoConstraints = false
        tbvi.backgroundColor = .gray
        return tbvi
    }()
    
    let titleLabel: UILabel = {
        let vi = UILabel()
        vi.text = "Blockchian Global 社区"
        vi.textColor = .black
        vi.textAlignment = .center
        return vi
    }()
    
    
}
