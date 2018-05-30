//
//  OtherOptionViewController.swift
//  news app for blockchain
//
//  Created by Rock on 15/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class OtherOptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    let data = ["我的钱包","收藏列表","市场行情","快讯","新闻"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otherOptionTableView.delegate = self
        otherOptionTableView.dataSource = self
        navigationItem.titleView = titleLabel
        
        // Do any additional setup after loading the view.
        view.addSubview(otherOptionTableView)
        otherOptionTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        otherOptionTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        otherOptionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        otherOptionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
//        rootView.addSubview(label)
//        view.addConstraintsWithFormat(format: "H:|-100-[v0]", views: label)
//        view.addConstraintsWithFormat(format: "V:|-100-[v0]", views: label)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.3294117647, green: 0.7019607843, blue: 0.6901960784, alpha: 0.8015839041)
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let otherOptionTableView: UITableView = {
        let tbvi = UITableView()
        tbvi.translatesAutoresizingMaskIntoConstraints = false
        tbvi.backgroundColor = .white
        return tbvi
    }()
    
//    let label: UILabel = {
//        let la = UILabel()
//        la.text = "This is the default display menu"
//        la.textAlignment = .center
//        return la
//    }()
    
    let titleLabel: UILabel = {
        let vi = UILabel()
        vi.text = "默认显示页面"
        vi.textColor = .black
        vi.textAlignment = .center
        return vi
    }()
    
}
