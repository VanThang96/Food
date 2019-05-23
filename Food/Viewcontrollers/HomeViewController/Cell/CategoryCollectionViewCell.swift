//
//  CategoryCollectionViewCell.swift
//  Food
//
//  Created by win on 5/21/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imvMenu: UIImageView!
    @IBOutlet weak var lbMenu: UILabel!
    
    var category : Category? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.imvMenu.imageFromUrl(urlString: (self?.category?.image)!)
                self?.lbMenu.text = self?.category?.name
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
