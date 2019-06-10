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
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = navTitle
    }
    fileprivate func setupUI(){
        foodViewModel = FoodViewModel()
        foodViewModel.fetchFoods(menuId: menuId, onSuccess: { [weak self] in
            self?.foodCollectionView.reloadData()
        }) { (error) in
            print(error!)
        }
        foodCollectionView.register(UINib(nibName: String(describing: FoodCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: foodCellId)
    }
    
}
//MARK:- CollectionViewDataSource
extension FoodViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodViewModel.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: foodCellId, for: indexPath) as! FoodCollectionViewCell
        cell.food = foodViewModel.getFood(atIndex: indexPath.item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Category", bundle: nil)
        let foodDetailVC = storyboard.instantiateViewController(withIdentifier: "FoodDetailViewController") as! FoodDetailViewController
        foodDetailVC.food = foodViewModel.getFood(atIndex: indexPath.item)
        foodDetailVC.foodId = foodViewModel.getFoodId(atIndex: indexPath.item)
        self.navigationController?.pushViewController(foodDetailVC, animated: true)
    }
}
//MARK:- CollectionViewDelegate
extension FoodViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
}
