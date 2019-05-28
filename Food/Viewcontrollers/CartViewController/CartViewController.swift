//
//  CartViewController.swift
//  Food
//
//  Created by win on 5/26/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    //MARK:- IBOulet
    @IBOutlet weak var cartCollectionView: UICollectionView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var lbPrice: UILabel!
    
    //MARK:- Constant
    let cellId = "cellId"
    
    //MARK:- Variable
    var orderDetailViewModel : OrderDetailViewModel!
    
    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        firstSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }
    
    //MARK:- Method
    fileprivate func setupCollectionView() {
        cartCollectionView.register(UINib(nibName: String(describing: CartCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    fileprivate func firstSetup() {
        orderDetailViewModel = OrderDetailViewModel()
    }
    fileprivate func reloadData(){
        cartCollectionView.reloadData()
        guard let totalPrice = orderDetailViewModel.getTotalPrice()  else {
            self.showAlert(message: "No Item in Cart")
            return
        }
        lbPrice.text = "$\(totalPrice).00"
    }
    override func viewWillLayoutSubviews() {
        cardView.layer.cornerRadius = 8
        cardView.clipsToBounds = true
        btnPlaceOrder.makeCornerAndGradient(startColor: UIColor(named: "#FF8C2B")!, endColor: UIColor(named: "#FF6322")!)
    }
}

//MARK:- CollectionViewDelegate
extension CartViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 16, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

//MARK:- CollectionViewDataSource
extension CartViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderDetailViewModel.getCount()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CartCollectionViewCell
        cell.orderDetail = orderDetailViewModel.getOrderDetail(atIndex: indexPath.item)
        return cell
    }
}
