//
//  FoodDetailHeaderView.swift
//  Food
//
//  Created by win on 5/23/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

class FoodDetailHeaderView: UICollectionReusableView {
    //MARK:- IBOulet
    @IBOutlet weak var imvHeader: UIImageView!
    @IBOutlet weak var lbFoodHeader: UILabel!
    
    //MARK:- Variable
    var food : Food?{
        didSet{
            DispatchQueue.main.async {[weak self] in
                self?.imvHeader.imageFromUrl(urlString: (self?.food?.image)!)
                self?.lbFoodHeader.text = self?.food?.name
            }
        }
    }
    var animator : UIViewPropertyAnimator!
    
    //MARK:- Init
    override func awakeFromNib() {
        super.awakeFromNib()
        setupVisualEffectBlur()
    }
    
    //MARK:- Method
    fileprivate func setupVisualEffectBlur(){
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .linear, animations: {[weak self] in
            //treat this area as the end state of your animation
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            visualEffectView.translatesAutoresizingMaskIntoConstraints  = false
            
            self!.addSubview(visualEffectView)
            let visualEffectViewConstraint = [
                visualEffectView.topAnchor.constraint(equalTo: self!.topAnchor),
                visualEffectView.leadingAnchor.constraint(equalTo: self!.leadingAnchor),
                visualEffectView.trailingAnchor.constraint(equalTo: self!.trailingAnchor),
                visualEffectView.bottomAnchor.constraint(equalTo: self!.bottomAnchor)
            ]
            NSLayoutConstraint.activate(visualEffectViewConstraint)
        })
    }
}
