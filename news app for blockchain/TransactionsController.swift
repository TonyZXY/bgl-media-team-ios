//
//  TransactionsController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 23/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class TransactionsController: UITableViewController{
    var cells = ["CoinTypeCell","CoinMarketCell","TradePairsCell","PriceCell","NumberCell","DateCell","TimeCell","ExpensesCell","AdditionalCell"]
    var selectedindex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TransCoinTypeCell.self, forCellReuseIdentifier: "CoinTypeCell")
        tableView.register(TransCoinMarketCell.self, forCellReuseIdentifier: "CoinMarketCell")
        tableView.register(TransTradePairsCell.self, forCellReuseIdentifier: "TradePairsCell")
        tableView.register(TransPriceCell.self, forCellReuseIdentifier: "PriceCell")
        tableView.register(TransNumberCell.self, forCellReuseIdentifier: "NumberCell")
        tableView.register(TransDateCell.self, forCellReuseIdentifier: "DateCell")
        tableView.register(TransTimeCell.self, forCellReuseIdentifier: "TimeCell")
        tableView.register(TransExpensesCell.self, forCellReuseIdentifier: "ExpensesCell")
        tableView.register(TransAdditionalCell.self, forCellReuseIdentifier: "AdditionalCell")
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.init(red:47/255.0, green:49/255.0, blue:54/255.0, alpha:1)
        tableView.delegate = self
        tableView.dataSource = self
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cells[indexPath.row], for: indexPath)
        cell.backgroundColor = UIColor.init(red:47/255.0, green:49/255.0, blue:54/255.0, alpha:1)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
