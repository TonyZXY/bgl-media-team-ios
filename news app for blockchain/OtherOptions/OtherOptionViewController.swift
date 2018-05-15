//
//  OtherOptionViewController.swift
//  news app for blockchain
//
//  Created by Rock on 15/5/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class OtherOptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var otherTableView: UITableView!
    
    let data = ["启动时默认显示页面"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        otherTableView.dataSource = self
        otherTableView.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = otherTableView.dequeueReusableCell(withIdentifier: "othertbCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.3294117647, green: 0.7019607843, blue: 0.6901960784, alpha: 0.8015839041)
        return cell
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
