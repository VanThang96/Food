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
    var food : Food? {
        didSet {
            lbFoodDetailName.text = food?.name
            heightConstaintOfCardViewDescription.constant = (food?.description.height(withConstrainedWidth: lbFoodDetailDescriptions.bounds.width, font: UIFont.systemFont(ofSize: 17)))! + 32
            lbFoodDetailDescriptions.text = food?.description
            let attributed = NSMutableAttributedString(attributedString: NSAttributedString(string: "$ ", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]))
            attributed.append(NSAttributedString(string: (food?.price)!, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17),NSAttributedString.Key.foregroundColor : UIColor(named: "#FF8C2B")!]))
            lbFoodDetailPrice.attributedText = attributed
            
        }
    }
    
    //MARK:- Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print(lbFoodDetailDescriptions.frame.width)
        print(frame.width)
        btnAddCartItem.layer.cornerRadius = btnAddCartItem.frame.height / 2
        btnAddCartItem.clipsToBounds = true
        btnRemoveCartItem.layer.cornerRadius = btnRemoveCartItem.frame.height / 2
        btnRemoveCartItem.clipsToBounds = true
        
        cardViewForTitle.cornerRadiusAndShadowForCardView()
        cardViewForDescription.cornerRadiusAndShadowForCardView()
    }
    
    //MARK:- IBAction
    @IBAction func actionRemoveCartItem(_ sender: UIButton) {
        print("remove")
    }
    @IBAction func actionAddCartItem(_ sender: Any) {
        print("add")
    }
    
}
