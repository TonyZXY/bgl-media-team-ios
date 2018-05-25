//
//  MasterViewController.swift
//  news app for blockchain
//
//  Created by Rock on 25/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let sections = ["关于我们","应用设置选项"] // Two Sections' names
    let items = [
        ["关于Blockchain Global","Blockchain Global社区"], //About us list items
        ["默认法定货币","应用通知选项","界面显示选项","其他选项"] // other app settings
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupRootView()
        tableView00.dataSource = self
        tableView00.delegate = self
        navigationItem.titleView = titleLabel
        
        //splitViewController?.delegate = self
        //print(self.navigationController as Any)
    }
    
    func setupRootView(){
        view.addSubview(tableView00)
        //view.addSubview(naviBar)
        //view.addConstraintsWithFormat(format: "H:|[v0]|", views: naviBar)
        //view.addConstraintsWithFormat(format: "V:|[v0]|", views: naviBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: tableView00)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: tableView00)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.3294117647, green: 0.7019607843, blue: 0.6901960784, alpha: 0.8015839041)
        return cell
    }
    
    let tableView00: UITableView = {
        let tbvi = UITableView()
        
        return tbvi
    }()
    
    let titleLabel: UILabel = {
        let vi = UILabel()
        vi.text = "Blockchain Global"
        vi.textColor = .black
        vi.textAlignment = .center
        return vi
    }()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexSelected = indexPath
        print(indexSelected)
        
        if (indexSelected == [0,0]) {
            let detailViewController = AboutUsDetailViewController()
            detailViewController.label.text = "changed to about us"
            self.showDetailViewController(UINavigationController(rootViewController: detailViewController), sender: self)
            
        }
        
        if (indexSelected == [0,1]) {
            let detailViewController = WebMainViewController()
            detailViewController.label.text = "changed to community main menu"
            self.showDetailViewController(UINavigationController(rootViewController: detailViewController), sender: self)
            
        }
        
        if (indexSelected == [1,0]) {
            let detailViewController = DefaultCurrencyViewController()
            detailViewController.label.text = "changed to default currency menu"
            self.showDetailViewController(UINavigationController(rootViewController: detailViewController), sender: self)
        }
        
        if (indexSelected == [1,1]) {
            let detailViewController = NotificationViewController()
            detailViewController.label.text = "changed to notifications menu"
            self.showDetailViewController(UINavigationController(rootViewController: detailViewController), sender: self)
        }
        
        if (indexSelected == [1,2]) {
            let detailViewController = ViewOptionsViewController()
            detailViewController.label.text = "changed to view options menu"
            self.showDetailViewController(UINavigationController(rootViewController: detailViewController), sender: self)
        }
        
        if (indexSelected == [1,3]) {
            let detailViewController = OtherOptionViewController()
            detailViewController.label.text = "changed to default display page menu"
            self.showDetailViewController(UINavigationController(rootViewController: detailViewController), sender: self)
        }
        
        //let detailViewController = AboutUsDetailViewController()
        //detailViewController.label.text = "changed when click"
        //self.showDetailViewController(UINavigationController(rootViewController: detailViewController), sender: self)
        //self.navigationController?.pushViewController(NewViewController(), animated: true)
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

