//
//  FoodDetailCollectionViewCell.swift
//  Food
//
//  Created by win on 5/24/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

class FoodDetailCollectionViewCell: UICollectionViewCell {
    //MARK:- IBOulet
    @IBOutlet weak var lbFoodDetailName: UILabel!
    @IBOutlet weak var lbFoodDetailPrice: UILabel!
    @IBOutlet weak var btnRemoveCartItem: UIButton!
    @IBOutlet weak var btnAddCartItem: UIButton!
    @IBOutlet weak var lbCurrentNumberItem: UILabel!
    @IBOutlet weak var lbFoodDetailDescriptions: UILabel!
    @IBOutlet weak var cardViewForTitle: UIView!
    @IBOutlet weak var cardViewForDescription: UIView!
    @IBOutlet weak var heightConstaintOfCardViewDescription: NSLayoutConstraint!
    
    //MARK:- Variable
    var delegate : Delegate!
    var numberCurrent : Int = 1
    var food : Food? {
        didSet {
            lbFoodDetailName.text = food?.name
            heightConstaintOfCardViewDescription.constant = (food?.description.height(withConstrainedWidth: lbFoodDetailDescriptions.bounds.width, font: UIFont.systemFont(ofSize: 17)))! + 32
            lbFoodDetailDescriptions.text = food?.description
            lbFoodDetailPrice.text = food?.price
            
        }
    }
    //MARK:- Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnAddCartItem.layer.cornerRadius = btnAddCartItem.frame.height / 2
        btnAddCartItem.clipsToBounds = true
        btnRemoveCartItem.layer.cornerRadius = btnRemoveCartItem.frame.height / 2
        btnRemoveCartItem.clipsToBounds = true
        
        cardViewForTitle.cornerRadiusAndShadowForCardView()
        cardViewForDescription.cornerRadiusAndShadowForCardView()
    }
    
    //MARK:- IBAction
    @IBAction func actionRemoveCartItem(_ sender: UIButton) {
        guard Int(lbCurrentNumberItem.text!)! > 1 else {
            return
        }
        lbCurrentNumberItem.text = String(Int(lbCurrentNumberItem.text!)! - 1)
        lbFoodDetailPrice.text = String(Int(lbCurrentNumberItem.text!)! * Int((food?.price)!)!)
        delegate.getQuantityProduct(quantity: Int(lbCurrentNumberItem.text!)!)
    }
    @IBAction func actionAddCartItem(_ sender: Any) {
        lbCurrentNumberItem.text = String(Int(lbCurrentNumberItem.text!)! + 1)
        lbFoodDetailPrice.text = String(Int(lbCurrentNumberItem.text!)! * Int((food?.price)!)!)
        delegate.getQuantityProduct(quantity: Int(lbCurrentNumberItem.text!)!)
    }
}
