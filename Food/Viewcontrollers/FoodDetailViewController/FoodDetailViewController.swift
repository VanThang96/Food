//
//  FoodDetailViewController.swift
//  Food
//
//  Created by win on 5/23/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit



class FoodDetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK:- Constant
    let reuseIdentifier = "Cell"
    let headerId = "headerId"
    let padding : CGFloat = 16
    let headerHeight : CGFloat = 360
    
    //MARK:- Variable
    var food : Food!
    var imageHeader : String!
    var lbHeader : String!
    lazy var button : UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewFlowLayout()
        setupCollectionView()
        setupAddToCartButton()
    }
    override func willMove(toParent parent: UIViewController?) {
        header?.animator.stopAnimation(true)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(white: 1, alpha: 1)]
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor(named: "#FF6322")
        navigationController?.navigationBar.backgroundColor = .clear
        UIApplication.shared.statusBarView?.backgroundColor = .clear
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    //MARK:- Method
    fileprivate func setupCollectionView() {
        navigationItem.title = lbHeader
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(white: 1, alpha: 0)]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .white
        collectionView.register(UINib(nibName: String(describing: FoodDetailHeaderView.self) ,  bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(UINib(nibName: String(describing: FoodDetailCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    fileprivate func setupCollectionViewFlowLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: padding, right: padding)
        }
    }
    fileprivate func setupAddToCartButton() {
        view.addSubview(button)
        let buttonConstaint = [
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(49 + 34 + padding)), //49: Tabbar heigth , 34: Home indicator
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: 48),
            button.widthAnchor.constraint(equalToConstant: 48),
            ]
        NSLayoutConstraint.activate(buttonConstaint)
        button.bringSubviewToFront(collectionView)
    }
    
    //MARK:- CollectionViewDelegate & CollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FoodDetailCollectionViewCell
        cell.food = food
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: view.frame.height - (44 + 44) - 16) //44: Height of statusBar , 44: Height of NavigationBar
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    var header : FoodDetailHeaderView?
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? FoodDetailHeaderView
        header?.food = food
        return header!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: headerHeight)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let  contentOffsetY = scrollView.contentOffset.y / headerHeight
        if contentOffsetY > 0 {
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: contentOffsetY)
            let titleColor = UIColor(white: 0, alpha: contentOffsetY)
            self.navigationController?.navigationBar.backgroundColor = color
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : titleColor]
            self.navigationController?.navigationBar.tintColor = titleColor
            UIApplication.shared.statusBarView?.backgroundColor = color
            self.header?.lbFoodHeader.textColor = UIColor(white: 0, alpha: 1 - contentOffsetY)
        } else {
            let color = UIColor(red: 1, green: 1, blue: 1, alpha: contentOffsetY)
            let titleColor = UIColor(white: 0, alpha: contentOffsetY)
            self.navigationController?.navigationBar.backgroundColor = color
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : titleColor]
            self.navigationController?.navigationBar.tintColor = .white
            UIApplication.shared.statusBarView?.backgroundColor = color
            self.header!.animator.fractionComplete = abs(scrollView.contentOffset.y) / 100
        }
    }
    
}
