//
//  ViewOptionsViewController.swift
//  news app for blockchain
//
//  Created by Rock on 25/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class ViewOptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    let data = ["大字体显示","切换至神色主题","不显示持有量为零的数字代币"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewOptionTableView.delegate = self
        viewOptionTableView.dataSource = self
        
        navigationItem.titleView = titleLabel
        
        // Do any additional setup after loading the view.
        view.addSubview(viewOptionTableView)
        viewOptionTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        viewOptionTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewOptionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewOptionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.3294117647, green: 0.7019607843, blue: 0.6901960784, alpha: 0.8015839041)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    let rootView: UIView = {
//        let vi = UIView()
//        vi.translatesAutoresizingMaskIntoConstraints = false
//        vi.backgroundColor = .white
//        return vi
//    }()
    
    let viewOptionTableView: UITableView = {
        let tbvi = UITableView()
        tbvi.translatesAutoresizingMaskIntoConstraints = false
        tbvi.backgroundColor = .white
        return tbvi
    }()
    
//    let label: UILabel = {
//        let la = UILabel()
//        la.text = "This is the View optinons menu"
//        la.textAlignment = .center
//        return la
//    }()
    
    let titleLabel: UILabel = {
        let vi = UILabel()
        vi.text = "查看选项"
        vi.textColor = .black
        vi.textAlignment = .center
        return vi
    }()
    
}
