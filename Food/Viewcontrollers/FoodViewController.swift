//
//  FoodViewController.swift
//  Food
//
//  Created by win on 5/22/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController {
    //MARK:- IBOulet
    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    //MARK:- Variable
    var menuId : String!
    var navTitle : String!
    var foodViewModel : FoodViewModel!
    
    //MARK:- Constant
    let foodCellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    fileprivate func setupUI(){
        navigationItem.title = navTitle
        foodViewModel = FoodViewModel()
        foodViewModel.fetchFoods(menuId: menuId, onSuccess: { [weak self] in
            self?.foodCollectionView.reloadData()
        }) { (error) in
            print(error!)
        }
        foodCollectionView.register(UINib(nibName: String(describing: FoodCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: foodCellId)
    }
}
extension FoodViewController : UICollectionViewDataSource {
    //MARK:- CollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodViewModel.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: foodCellId, for: indexPath) as! FoodCollectionViewCell
        cell.food = foodViewModel.getFood(atIndex: indexPath.item)
        return cell
    }
    
}
extension FoodViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
}
