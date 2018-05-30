//
//  NotificationViewController.swift
//  news app for blockchain
//
//  Created by Rock on 25/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    

    let data = ["每日数字代币交易信息更新","重大行情变化通知","快讯提醒","原创文章更新提醒","新闻推送提醒"]
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
        navigationItem.titleView = titleLabel
        
        // Do any additional setup after loading the view.
        view.addSubview(notificationTableView)
        notificationTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        notificationTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        notificationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        notificationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
//        rootView.addSubview(label)
//        view.addConstraintsWithFormat(format: "H:|-100-[v0]", views: label)
//        view.addConstraintsWithFormat(format: "V:|-100-[v0]", views: label)
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
    
    let notificationTableView: UITableView = {
        let tbvi = UITableView()
        tbvi.translatesAutoresizingMaskIntoConstraints = false
        tbvi.backgroundColor = .white
        return tbvi
    }()
    
    let titleLabel: UILabel = {
        let vi = UILabel()
        vi.text = "程序通知选项"
        vi.textColor = .black
        vi.textAlignment = .center
        return vi
    }()
    
    let notificationSwitch: UISwitch = {
        let notiswitch = UISwitch()
        return notiswitch
    }()
    
}

