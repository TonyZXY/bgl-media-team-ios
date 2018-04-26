//
//  TransactionsController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 23/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class TransactionsController: UITableViewController{
    var cells = ["CoinType","CoinMarket","TradePairs","Price","Number","Date","Time","Expenses","Additional"]
    
    var selectedindex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(CoinType.self, forCellReuseIdentifier: "CoinType")
        tableView.register(CoinMarket.self, forCellReuseIdentifier: "CoinMarket")
        tableView.register(TradePairs.self, forCellReuseIdentifier: "TradePairs")
        tableView.register(Price.self, forCellReuseIdentifier: "Price")
        tableView.register(Number.self, forCellReuseIdentifier: "Number")
        tableView.register(Date.self, forCellReuseIdentifier: "Date")
        tableView.register(Time.self, forCellReuseIdentifier: "Time")
        tableView.register(Expenses.self, forCellReuseIdentifier: "Expenses")
        tableView.register(Additional.self, forCellReuseIdentifier: "Additional")
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
    
    //Class for each Cell
    class CoinType:UITableViewCell{
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupviews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init has not been completed")
        }
        
        let coinLabel:UILabel = {
            let label = UILabel()
            label.text = "币种"
            label.textColor = UIColor.init(red:187/255.0, green:187/255.0, blue:187/255.0, alpha:1)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let coin: UILabel = {
            let label = UILabel()
            label.text = "Bitcoins"
            label.textColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let coinarrow: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "navigation_arrow.png"))
            imageView.clipsToBounds = true
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
        func setupviews(){
            addSubview(coinLabel)
            addSubview(coin)
            addSubview(coinarrow)
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinLabel,"v1":coin,"v3":coinarrow]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinLabel,"v1":coin,"v3":coinarrow]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-10-[v1]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinLabel,"v1":coin,"v3":coinarrow]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v3(10)]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinLabel,"v1":coin,"v3":coinarrow]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v3(10)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinLabel,"v1":coin,"v3":coinarrow]))
            let myLabelverticalConstraint = NSLayoutConstraint(item: coinarrow, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([myLabelverticalConstraint])
//            NSLayoutConstraint.activate([myLabelhorizontalConstraint])
            
        }
    }
    
    
    class CoinMarket:UITableViewCell{
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupviewsk()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init has not been completed")
        }
        
        let marketLabel:UILabel = {
            let label = UILabel()
            label.text = "交易市场"
            label.textColor = UIColor.init(red:187/255.0, green:187/255.0, blue:187/255.0, alpha:1)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let market: UILabel = {
            let label = UILabel()
            label.text = "BTCMarkets"
            label.textColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let marketarrow: UIImageView = {
//            let imageView  = UIImageView();
            let imageView = UIImageView(image: UIImage(named: "navigation_arrow.png"))
//            imageView.frame = CGRect(x:0, y: 0, width: 30, height: 30)
            imageView.clipsToBounds = true
            imageView.contentMode = UIViewContentMode.scaleAspectFit
//            imageView.image = UIImage(named:"bcg_logo.png")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
        func setupviewsk(){
            addSubview(marketLabel)
            addSubview(market)
            addSubview(marketarrow)
        
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":marketLabel,"v1":market,"v3":marketarrow]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":marketLabel,"v1":market,"v3":marketarrow]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-10-[v1]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":marketLabel,"v1":market,"v3":marketarrow]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v3(10)]-16-|", options: .alignAllCenterY, metrics: nil, views: ["v0":marketLabel,"v1":market,"v3":marketarrow]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v3(10)]", options: .alignAllCenterX, metrics: nil, views: ["v0":marketLabel,"v1":market,"v3":marketarrow]))
            let myLabelverticalConstraint = NSLayoutConstraint(item: marketarrow, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([myLabelverticalConstraint])
        }
    }
    
    class TradePairs:UITableViewCell{
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupviews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init has not been completed")
        }
        
        let tradeLabel:UILabel = {
            let label = UILabel()
            label.text = "兑换币种"
            label.textColor = UIColor.init(red:187/255.0, green:187/255.0, blue:187/255.0, alpha:1)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let trade: UILabel = {
            let label = UILabel()
            label.text = "BTC/AUD"
            label.textColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let tradearrow: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "navigation_arrow.png"))
            imageView.clipsToBounds = true
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        func setupviews(){
            addSubview(tradeLabel)
            addSubview(trade)
            addSubview(tradearrow)
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":tradeLabel,"v1":trade,"v3":tradearrow]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":tradeLabel,"v1":trade,"v3":tradearrow]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-10-[v1]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":tradeLabel,"v1":trade,"v3":tradearrow]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v3(10)]-16-|", options: .alignAllCenterY, metrics: nil, views: ["v0":tradeLabel,"v1":trade,"v3":tradearrow]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v3(10)]", options: .alignAllCenterX, metrics: nil, views: ["v0":tradeLabel,"v1":trade,"v3":tradearrow]))
            let myLabelverticalConstraint = NSLayoutConstraint(item: tradearrow, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([myLabelverticalConstraint])
        }
    }
    
    class Price:UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate{
        let items = ["单价","总额"]
        
        var selectitems: String = ""
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return items.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return items[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectitems = items[row]
        }
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupviews()
            createdonebutton()
            setPriceTypebutton()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init has not been completed")
        }
    
        let priceLabel:UILabel = {
            let label = UILabel()
            label.text = "买入价格"
            label.textColor = UIColor.init(red:187/255.0, green:187/255.0, blue:187/255.0, alpha:1)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let price: UITextField = {
            let textfield = UITextField()
            textfield.resignFirstResponder()
            textfield.keyboardType = UIKeyboardType.decimalPad
            textfield.placeholder = "输入买入价格"
            textfield.tintColor = UIColor.white
            textfield.textColor = UIColor.white
            textfield.frame = CGRect(x:50, y: 70, width: 200, height: 30)
            textfield.translatesAutoresizingMaskIntoConstraints = false
            return textfield
        }()
        
        let priceType: UITextField = {
            let textfield = UITextField()
            textfield.textColor = UIColor.white
            textfield.layer.cornerRadius = 8;
            textfield.text = "单价"
            textfield.tintColor = .clear
            textfield.layer.borderColor = UIColor.white.cgColor
            textfield.layer.borderWidth = 1
            
            // Create a padding view for padding on left
            textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
            textfield.leftViewMode = .always
            
            // Create a padding view for padding on right
            textfield.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
            textfield.rightViewMode = .always
            textfield.translatesAutoresizingMaskIntoConstraints = false
            return textfield
        }()
        
        func setupviews(){
            addSubview(priceLabel)
            addSubview(price)
            addSubview(priceType)
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":priceLabel,"v1":price,"v3":priceType]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v1]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":priceLabel,"v1":price,"v3":priceType]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-10-[v1(30)]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":priceLabel,"v1":price,"v3":priceType]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v3]-16-|", options: .alignAllCenterY, metrics: nil, views: ["v0":priceLabel,"v1":price,"v3":priceType]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v3(==v1)]", options: .alignAllCenterX, metrics: nil, views: ["v0":priceLabel,"v1":price,"v3":priceType]))
            let myLabelverticalConstraint = NSLayoutConstraint(item: priceType, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: price, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([myLabelverticalConstraint])
        }
        
        func createdonebutton() {
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let donebutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done
                , target: self, action: #selector(doneclick))
            toolbar.setItems([donebutton], animated: false)
            price.inputAccessoryView = toolbar
        }
        
        @objc func doneclick(){
            priceType.text = selectitems + "  ▼"
            self.endEditing(true)
        }
        
        func setPriceTypebutton() {
            let pickdd = UIPickerView()
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let donebutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done
                , target: self, action: #selector(doneclick))
            toolbar.setItems([donebutton], animated: false)
            priceType.inputAccessoryView = toolbar
            priceType.inputView = pickdd
            pickdd.delegate = self
            pickdd.dataSource = self
        }
        
    }
    
    class Number:UITableViewCell, UITextFieldDelegate{
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupviews()
            _ = createKeyboarddonebutton()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init has not been completed")
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }

        let numberLabel:UILabel = {
            let label = UILabel()
            label.text = "购买数量"
            label.textColor = UIColor.init(red:187/255.0, green:187/255.0, blue:187/255.0, alpha:1)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let number: UITextField = {
            let textfield = UITextField()
            textfield.keyboardType = UIKeyboardType.decimalPad
//            textfield.resignFirstResponder()
            textfield.textColor = UIColor.white
            textfield.tintColor = .clear
            textfield.frame = CGRect(x:50, y: 70, width: 200, height: 30)
            textfield.translatesAutoresizingMaskIntoConstraints = false
            return textfield
        }()
        
        func setupviews(){
            addSubview(numberLabel)
            addSubview(number)
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":numberLabel,"v1":number]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v1]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":numberLabel,"v1":number]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-10-[v1(30)]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":numberLabel,"v1":number]))
        }
        
        func createKeyboarddonebutton()->UIToolbar {
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let donebutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done
                , target: self, action: #selector(doneclick))
            toolbar.setItems([donebutton], animated: false)
            number.inputAccessoryView = toolbar
            return toolbar
        }
        
        @objc func doneclick(){
            self.endEditing(true)
        }
    }
    
    class Date:UITableViewCell,UITextFieldDelegate {
        let datepicker = UIDatePicker()
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupviews()
            date.delegate = self
            _ = createdatepicker()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init has not been completed")
        }
        
        let dateLabel:UILabel = {
            let label = UILabel()
            label.text = "购买日期"
            label.textColor = UIColor.init(red:187/255.0, green:187/255.0, blue:187/255.0, alpha:1)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let date: UITextField = {
            let textfield = UITextField()
//            textfield.frame = CGRect(x:50, y: 70, width: 200, height: 30)
            textfield.translatesAutoresizingMaskIntoConstraints = false
            textfield.textColor = UIColor.white
            return textfield
        }()
       
        
      
        
        func setupviews(){
            addSubview(dateLabel)
            addSubview(date)
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":dateLabel,"v1":date]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v1]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":dateLabel,"v1":date]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-10-[v1(30)]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":dateLabel,"v1":date]))
        }
        
        func createdatepicker() -> UIDatePicker{
            //toolbar
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            //bar button item
            let done = UIBarButtonItem(barButtonSystemItem:.done, target: self, action:#selector(doneclick))
            toolbar.setItems([done], animated: false)
            datepicker.datePickerMode = .date
            date.inputAccessoryView = toolbar
            date.inputView = datepicker
            return datepicker
        }
        
        @objc func doneclick(){
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            let dataString = formatter.string(from: datepicker.date)
            date.text = "\(dataString)"
            self.endEditing(true)
        }
    }

    
    class Time:UITableViewCell, UITextFieldDelegate{
        let datepicker = UIDatePicker()
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupviews()
            time.delegate = self
            _ = createdatepicker()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init has not been completed")
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            textField.resignFirstResponder()
//            self.window?.endEditing(true)
            
            return true
        }
        
        let timeLabel:UILabel = {
            let label = UILabel()
            label.text = "购买时间"
            label.textColor = UIColor.init(red:187/255.0, green:187/255.0, blue:187/255.0, alpha:1)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let time: UITextField = {
            let textfield:UITextField = UITextField()
            textfield.textColor = UIColor.white
            textfield.keyboardType = UIKeyboardType.default
            textfield.frame = CGRect(x:50, y: 70, width: 200, height: 30)
            textfield.translatesAutoresizingMaskIntoConstraints = false
            return textfield
        }()
        
        func setupviews(){
            addSubview(timeLabel)
            addSubview(time)
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":timeLabel,"v1":time]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v1]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":timeLabel,"v1":time]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-10-[v1]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":timeLabel,"v1":time]))
        }
        
        func createdatepicker() -> UIDatePicker{
            //toolbar
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            //bar button item
            let done = UIBarButtonItem(barButtonSystemItem:.done, target: self, action:#selector(doneclick))
            toolbar.setItems([done], animated: false)
            datepicker.datePickerMode = .time
            time.inputAccessoryView = toolbar
            time.inputView = datepicker
            return datepicker
        }
        
        @objc func doneclick(){
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            let dataString = formatter.string(from: datepicker.date)
            time.text = "\(dataString)"
            self.endEditing(true)
        }
    }
    
    class Expenses:UITableViewCell,UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource{
        let items = ["%BTC","%AUD","AUD","USD","BTC"]
    
        var selectitems: String = ""
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupviews()
            _ = createKeyboarddonebutton()
            createKeyboarddonebutton2()
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init has not been completed")
        }
        
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return items.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return items[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectitems = items[row]
            
        }
        
        let expensesLabel:UILabel = {
            let label = UILabel()
            label.text = "交易费用"
            label.textColor = UIColor.init(red:187/255.0, green:187/255.0, blue:187/255.0, alpha:1)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let expenses: UITextField = {
            let textfield = UITextField()
            textfield.textColor = UIColor.white
            textfield.layer.cornerRadius = 8;
            textfield.keyboardType = UIKeyboardType.decimalPad
            textfield.layer.borderColor = UIColor.white.cgColor
            textfield.layer.borderWidth = 1
            textfield.frame = CGRect(x:50, y: 70, width: 200, height: 30)
            textfield.translatesAutoresizingMaskIntoConstraints = false
            
            // Create a padding view for padding on left
            textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
            textfield.leftViewMode = .always
            
            // Create a padding view for padding on right
            textfield.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
            textfield.rightViewMode = .always
            textfield.clipsToBounds = false
            return textfield
        }()
        
        let expensesbutton: UITextField = {
            let textfield = UITextField()
            textfield.textColor = UIColor.white
            textfield.layer.cornerRadius = 8;
            textfield.text = "%BTC  ▼"
            textfield.tintColor = .clear
            textfield.layer.borderColor = UIColor.white.cgColor
            textfield.layer.borderWidth = 1
            // Create a padding view for padding on left
            textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
            textfield.leftViewMode = .always
            
            // Create a padding view for padding on right
            textfield.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
            textfield.rightViewMode = .always
            textfield.clipsToBounds = false
//            textfield.frame = CGRect(x:50, y: 70, width: 200, height: 30)
            textfield.translatesAutoresizingMaskIntoConstraints = false
            return textfield
        }()
        
        func setupviews(){
            addSubview(expensesLabel)
            addSubview(expenses)
            addSubview(expensesbutton)
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":expensesLabel,"v1":expenses]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v1(200)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":expensesLabel,"v1":expenses]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-10-[v1(30)]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":expensesLabel,"v1":expenses]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v3]-16-|", options: .alignAllCenterY, metrics: nil, views: ["v0":expensesLabel,"v1":expenses,"v3":expensesbutton]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v3(==v1)]", options: .alignAllCenterX, metrics: nil, views: ["v0":expensesLabel,"v1":expenses,"v3":expensesbutton]))
            let myLabelverticalConstraint = NSLayoutConstraint(item: expensesbutton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: expenses, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([myLabelverticalConstraint])
        }
        
        func createKeyboarddonebutton()->UIToolbar {
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let donebutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done
                , target: self, action: #selector(doneclick))
            toolbar.setItems([donebutton], animated: false)
            expenses.inputAccessoryView = toolbar
            return toolbar
        }
        
        @objc func doneclick(){
            expensesbutton.text = selectitems + "  ▼"
            self.endEditing(true)
        }
        
        func createKeyboarddonebutton2() {
            let pickdd = UIPickerView()
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let donebutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done
                , target: self, action: #selector(doneclick))
            toolbar.setItems([donebutton], animated: false)
            expensesbutton.inputAccessoryView = toolbar
            expensesbutton.inputView = pickdd
            pickdd.delegate = self
            pickdd.dataSource = self
        }
        
    }
    
    class Additional:UITableViewCell{
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupviews()
            _ = createKeyboarddonebutton()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init has not been completed")
        }
        
        let additionalLabel:UILabel = {
            let label = UILabel()
            label.text = "附加信息"
            label.textColor = UIColor.init(red:187/255.0, green:187/255.0, blue:187/255.0, alpha:1)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let additional: UITextField = {
            let textfield = UITextField()
            textfield.textColor = UIColor.white
//            textfield.leftView?.frame = CGRect(x:10, y: 10, width: 200, height: 30)
//            textfield.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
            
            // Create a padding view for padding on left
            textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
            textfield.leftViewMode = .always
            
            // Create a padding view for padding on right
            textfield.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
            textfield.rightViewMode = .always
            textfield.clipsToBounds = false
    
                //            let paddingView = UIView(frame: CGRect(x: 30, y: 0, width: 15, height: textfield.frame.height))

            textfield.layer.cornerRadius = 8;
//            textfield.layer.masksToBounds = false;
            textfield.layer.borderColor = UIColor.white.cgColor
            textfield.layer.borderWidth = 1
            textfield.translatesAutoresizingMaskIntoConstraints = false
            return textfield
        }()
        
        func setupviews(){
            addSubview(additionalLabel)
            addSubview(additional)
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":additionalLabel,"v1":additional]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v1]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":additionalLabel,"v1":additional]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-10-[v1(30)]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":additionalLabel,"v1":additional]))
        }
        
        func createKeyboarddonebutton()->UIToolbar {
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let donebutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done
                , target: self, action: #selector(doneclick))
            toolbar.setItems([donebutton], animated: false)
            additional.inputAccessoryView = toolbar
            return toolbar
        }
        
        @objc func doneclick(){
            self.endEditing(true)
        }
    }
}
