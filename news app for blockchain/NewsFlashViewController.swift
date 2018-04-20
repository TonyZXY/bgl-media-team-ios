//
//  NewsFlashViewController.swift
//  news app for blockchain
//
//  Created by Sheng Li on 18/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsFlashViewController: UIViewController {
    
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    
    @IBOutlet weak var newsFlashTableView: UITableView!
    
    
    
    var shownCities = [String]() // Data source for UITableView
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"] // Our mocked API data source
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let label = dateAndTimeLabel {
            let formatter = DateFormatter()
            //formatter.dateStyle = .medium
            formatter.dateFormat = "M月d日 EEEE"
            // formatter.timeStyle = .medium
            formatter.locale = Locale(identifier: "zh_Hans")
            label.text = "今天" + formatter.string(from: Date())
            
            label.layer.cornerRadius = label.frame.height / 4
            // label.backgroundColor = .yellow
            label.clipsToBounds = true
            label.layer.borderWidth = 2
            label.layer.borderColor = #colorLiteral(red: 0.7294117647, green: 0.7294117647, blue: 0.7294117647, alpha: 1)
        }
        
        newsFlashTableView.tableFooterView = UIView() //Prevent empty rows

        // Do any additional setup after loading the view.
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
