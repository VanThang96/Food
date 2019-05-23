//
//  FoodDetailViewController.swift
//  Food
//
//  Created by win on 5/23/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let headerId = "headerId"

class FoodDetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let padding : CGFloat = 16

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewFlowLayout()
        setupCollectionView()
    }
    fileprivate func setupCollectionView() {
        navigationItem.title = "Strechy"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(white: 1, alpha: 0)]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(UINib(nibName: "FoodDetailHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    fileprivate func setupCollectionViewFlowLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 2 * padding, height: view.frame.height  - 88)
    }
    var header : FoodDetailHeaderView?
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? FoodDetailHeaderView
        header?.imvHeader.image = UIImage(named: "icon_category")
        header?.lbFoodHeader.text = "FOOD"
        return header!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 360)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let  contentOffsetY = scrollView.contentOffset.y / (360-88)
        if contentOffsetY > 0 {
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: contentOffsetY)
            let titleColor = UIColor(white: 0, alpha: contentOffsetY)
            UIApplication.shared.statusBarView?.backgroundColor = color
            self.navigationController?.navigationBar.backgroundColor = color
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : titleColor]
            header?.lbFoodHeader.textColor = UIColor(white: 0, alpha: 1 - contentOffsetY)
        } else {
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: contentOffsetY)
            let titleColor = UIColor(white: 0, alpha: contentOffsetY)
            UIApplication.shared.statusBarView?.backgroundColor = color
            self.navigationController?.navigationBar.backgroundColor = color
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : titleColor]
            header!.animator.fractionComplete = abs(scrollView.contentOffset.y) / 200
        }
    }

}
