//
//  DefaultCurrencyViewController.swift
//  news app for blockchain
//
//  Created by Rock on 15/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift

class DefaultCurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    let data = ["美元 USD","澳大利亚元 AUD","人民币 RMB","欧元 EURO","日元 JPY"]
    let realm = try! Realm()
    var filteredData: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        navigationItem.titleView = titleLabel
        
        // Do any additional setup after loading the view.
//        view.addSubview(currencyTableView)
//        currencyTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        currencyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        currencyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        currencyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(rootView)
        rootView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        rootView.addSubview(currencySearchBar)
        rootView.addSubview(currencyTableView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: currencyTableView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: currencyTableView)
        
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        currencyTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = data[indexPath.row]
        print(realm.configuration.fileURL ?? "")
        
        let newDC = defCurrency()
        newDC.id = "defCurrencyId00"
        newDC.defCur = str
        try! realm.write {
            realm.add(newDC, update:true)
        }
        
        self.navigationController?.popToRootViewController(animated: true)
        
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
    
    let currencyTableView: UITableView = {
        let tbvi = UITableView()
//        tbvi.translatesAutoresizingMaskIntoConstraints = false
//        tbvi.backgroundColor = .white
        return tbvi
    }()
    
    let currencySearchBar: UISearchBar = {
        let cursech = UISearchBar()
        return cursech
    }()
    
//    let label: UILabel = {
//        let la = UILabel()
//        la.text = "This is the default currency main menu"
//        la.textAlignment = .center
//        return la
//    }()
    
    let titleLabel: UILabel = {
        let vi = UILabel()
        vi.text = "默认法定货币"
        vi.textColor = .black
        vi.textAlignment = .center
        return vi
    }()

}
