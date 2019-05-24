//
//  FoodCollectionViewCell.swift
//  Food
//
//  Created by win on 5/22/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    //MARK:- IBOulet
    @IBOutlet weak var imvFood: UIImageView!
    @IBOutlet weak var lbFood: UILabel!
    
    //MARK:- Variable
    var food  : Food? {
        didSet{
            DispatchQueue.main.async {[weak self] in
                self?.imvFood.imageFromUrl(urlString: (self?.food?.image)!)
                self?.lbFood.text = self?.food?.name
            }
        }
    }
    //MARK:- Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
