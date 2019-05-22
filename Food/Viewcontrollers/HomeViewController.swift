//
//  HomeViewController.swift
//  Food
//
//  Created by win on 5/21/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    let categoryCellId = "cellId"
    var categoryViewModel :  CategoryViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    fileprivate func setupUI(){
        categoryViewModel = CategoryViewModel()
        categoryViewModel.fetchAllCategoty(onSuccess: {[weak self] in
            self?.categoryCollectionView.reloadData()
        }) { (error) in
            print(error!)
        }
        categoryCollectionView.register(UINib(nibName: String(describing: CategoryCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: categoryCellId)
    }
}
extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryViewModel.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellId, for: indexPath) as! CategoryCollectionViewCell
        cell.category = categoryViewModel.getCategory(atIndex: indexPath.item)
        return cell
    }
    
}
extension HomeViewController :UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
}

