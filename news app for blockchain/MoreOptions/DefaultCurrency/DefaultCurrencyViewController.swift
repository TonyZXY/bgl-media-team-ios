//
//  DefaultCurrencyViewController.swift
//  news app for blockchain
//
//  Created by Rock on 15/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift

class DefaultCurrencyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate{

    @IBOutlet weak var currencyTableView: UITableView!
    
    @IBOutlet weak var currencySearchBar: UISearchBar!
    
    let data = ["美元 USD","澳大利亚元 AUD","人民币 RMB","欧元 EURO","日元 JPY"]
    let realm = try! Realm()
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currencyTableView.dataSource = self
        currencyTableView.delegate = self
        currencySearchBar.delegate = self
        filteredData = data
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyTableCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row]
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
        //print(str)
        //let realm = try! Realm()
        print(realm.configuration.fileURL ?? "")
        
        let newDC = defCurrency()
        newDC.id = "defCurrencyId00"
        newDC.defCur = str
        try! realm.write {
            realm.add(newDC, update:true)
        }
        
        navigationController?.popToRootViewController(animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}