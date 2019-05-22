//
//  FoodCollectionViewCell.swift
//  Food
//
//  Created by win on 5/22/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imvFood: UIImageView!
    @IBOutlet weak var lbFood: UILabel!
    
    var food  : Food? {
        didSet{
            DispatchQueue.main.async {[weak self] in
                self?.imvFood.imageFromUrl(urlString: (self?.food?.image)!)
                self?.lbFood.text = self?.food?.name
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
