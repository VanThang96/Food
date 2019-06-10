//
//  OrderCollectionViewCell.swift
//  Food
//
//  Created by win on 6/3/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lbUUID: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbPhonenumber: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cardView.layer.cornerRadius = 4
        cardView.clipsToBounds = true
    }

}
