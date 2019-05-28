//
//  CartCollectionViewCell.swift
//  
//
//  Created by win on 5/26/19.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {

    //MARK:- IBOulet
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lbFoodName: UILabel!
    @IBOutlet weak var lbFoodPrice: UILabel!
    @IBOutlet weak var lbFoodNumber: UILabel!
    
    //MARK:- Variable
    var orderDetail : OrderDetail? {
        didSet {
            lbFoodName.text = orderDetail?.productName!
            lbFoodPrice.text = orderDetail?.price!
            lbFoodNumber.text = orderDetail?.quantity!
        }
    }
    
    //MARK:- Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.cornerRadius = 4
        cardView.clipsToBounds = true
        
        lbFoodNumber.layer.cornerRadius = lbFoodNumber.frame.height / 2
        lbFoodNumber.clipsToBounds = true
    }

}
