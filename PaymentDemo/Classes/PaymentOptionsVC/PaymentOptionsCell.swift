//
//  PaymentOptionsCell.swift
//  PaymentDemo
//
//  Created by Nikunj on 23/11/17.
//  Copyright © 2017 Nikunj. All rights reserved.
//

import UIKit

class PaymentOptionsCell: UITableViewCell {
    @IBOutlet var btnCheck : UIButton?
    @IBOutlet var lblCardName : UILabel?
    @IBOutlet var imgCard : UIImageView?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onClickBtn_Check(_ sender: UIButton) {
        
        if((sender.isSelected)){
            sender.setImage(UIImage(named: "uncheck.png"), for: UIControlState.normal)
            sender.isSelected = false
            print("check")
        } else {
            sender.setImage(UIImage(named: "check.png"), for: UIControlState.normal)
            print("uncheck")
            sender.isSelected = true
        }
    }

}
