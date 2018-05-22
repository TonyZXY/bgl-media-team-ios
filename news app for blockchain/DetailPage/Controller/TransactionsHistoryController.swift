//
//  TransactionsController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 21/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import RealmSwift

class TransactionsHistoryController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    let realm = try! Realm()
    var results = try! Realm().objects(NewsFlash.self).sorted(byKeyPath: "dateTime", ascending: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "History", for: indexPath) as! HistoryTableViewCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy, h:ma"
        cell.timeline.backColor = #colorLiteral(red: 0.7294117647, green: 0.7294117647, blue: 0.7294117647, alpha: 1)
        cell.dateLabel.text = "5月"
        cell.dateLabel.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
    }
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.gray
        
        return refreshControl
    }()
    
    func setUpView(){
        view.addSubview(historyTableView)
        view.addSubview(averageView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: averageView)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: averageView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: historyTableView,averageView)
        view.addConstraintsWithFormat(format: "V:[v1]-5-[v0]|", views: historyTableView,averageView)
    }
    
    lazy var historyTableView:UITableView = {
        var tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = ThemeColor().themeColor()
        let timelineTableViewCellNib = UINib(nibName: "TimeHistoryTableViewCell", bundle: Bundle(for: HistoryTableViewCell.self))
        tableView.register(timelineTableViewCellNib, forCellReuseIdentifier: "History")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 200
        tableView.delegate = self
        tableView.dataSource = self
        
        //Prevent empty rows
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2039215686, blue: 0.2235294118, alpha: 1)
        tableView.separatorStyle = .none
        tableView.addSubview(self.refresher)
        return tableView
    }()
    
    var averageView:UIView = {
        var view = UIView()
        view.backgroundColor = ThemeColor().themeColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.refresher.endRefreshing()
    }

}
