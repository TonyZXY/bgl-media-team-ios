//
//  WalletListCell.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 19/4/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit

class WalletListCell: UITableViewCell {

    @IBOutlet weak var coinType: UILabel!
    @IBOutlet weak var coinNumber: UILabel!
    @IBOutlet weak var coinProfit: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    @IBOutlet weak var walletCell: UIView!
    @IBOutlet weak var upDownlogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
