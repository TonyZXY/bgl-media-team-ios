//
//  TimelineTableViewCell.swift
//  TimelineTableViewCell
//
//  Created by Zheng-Xiang Ke on 2016/10/20.
//  Copyright © 2016年 Zheng-Xiang Ke. All rights reserved.
//

import UIKit

open class HistoryTableViewCell: UITableViewCell {
    

    @IBOutlet weak open var historyView: UIView!
    @IBOutlet weak open var dateLabel: UILabel!
    
    @IBOutlet weak var SinglePrice: UILabel!
    @IBOutlet weak var SinglePriceResult: UILabel!
    @IBOutlet weak var tradingPairs: UILabel!
    @IBOutlet weak var tradingPairsResult: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var amountResult: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var costResult: UILabel!
    @IBOutlet weak var worth: UILabel!
    @IBOutlet weak var worthResult: UILabel!
    @IBOutlet weak var delta: UILabel!
    @IBOutlet weak var deltaResult: UILabel!
    
    
    open var timelinePoint = HistoryPoint()
    open var timeline = HistoryLine()
    
    open var labelPoint:UILabel = {
        var label = UILabel()
        label.text = "B"
        label.layer.borderWidth = 0
        label.layer.cornerRadius = 15
        label.layer.backgroundColor = UIColor.green.cgColor
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        setUpLabelPoint()
        setUpTheme()
    }
    
    override open func draw(_ rect: CGRect) {
        timelinePoint.position = CGPoint(x: timeline.leftMargin + timeline.width / 2, y: timelinePoint.lineWidth)
        timeline.start = CGPoint(x: timeline.leftMargin + timeline.width / 2 + 15, y: timelinePoint.lineWidth + 30)
        timeline.end = CGPoint(x: timeline.start.x, y: self.bounds.size.height)
        timeline.draw(view: self.contentView)
    }
    
    func setUpTheme(){
        historyView.backgroundColor = ThemeColor().walletCellcolor()
    }
    
    func setUpLabelPoint(){
        addSubview(labelPoint)
        NSLayoutConstraint(item: labelPoint, attribute: .leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: timeline.leftMargin + timeline.width / 2).isActive = true
        NSLayoutConstraint(item: labelPoint, attribute: .top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: timelinePoint.lineWidth).isActive = true
        NSLayoutConstraint(item: labelPoint, attribute: .height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 30).isActive = true
         NSLayoutConstraint(item: labelPoint, attribute: .width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 30).isActive = true
    }
    
}
