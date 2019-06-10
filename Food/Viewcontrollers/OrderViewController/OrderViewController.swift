//
//  OrderViewController.swift
//  Food
//
//  Created by win on 6/3/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    @IBOutlet weak var orderCollectionView: UICollectionView!
    
    //MARK:- Constant
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    fileprivate func setupCollectionView() {
        orderCollectionView.register(UINib(nibName: String(describing: OrderCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: cellId)
    }
}
extension OrderViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! OrderCollectionViewCell
        return cell
    }
    
}
//MARK:- CollectionViewDelegate
extension OrderViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 16, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
