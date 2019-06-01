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
    var address : String!
    var listOrder : String!
    
    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        firstSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }
    override func viewWillLayoutSubviews() {
        cardView.layer.cornerRadius = 8
        cardView.clipsToBounds = true
        btnPlaceOrder.makeCornerAndGradient(startColor: UIColor(named: "#FF8C2B")!, endColor: UIColor(named: "#FF6322")!)
    }
    
    @IBAction func submitOrderAction(_ sender: Any) {
        guard let address = address else {
            showAlertAddAddress()
            return
        }
        // get userData when login success
        let userData = UserDefaults.standard.object(forKey: "Userdata") as! [String : String]
        
        // convert orderDetail from coredata  -> jsonString
        do {
            let jsonData = try JSONEncoder().encode(orderDetailViewModel.getOrderDetails())
            listOrder = String(data: jsonData, encoding: .utf8)
        } catch {
            print("Error fetching data from CoreData")
        }
        
        let orderRequest  = Request(phone: userData["phone"]!,
                                    name: userData["name"]!,
                                    address: address,
                                    total: lbPrice.text!,
                                    foods:listOrder)
        orderDetailViewModel.uploadRequest(uid: UUID().uuidString, request: orderRequest, onSuccess: {[weak self] in
            self?.orderDetailViewModel.deleteAllOrders()
            self?.orderDetailViewModel.fetchData()
            self?.cartCollectionView.reloadData()
            self?.displayToastMessage("Thank you for your orders", 1.5)
            self?.btnPlaceOrder.isEnabled = false
        }) { [weak self] in
            self?.displayToastMessage("Something went wrong", 1.5)
        }
    }
    
    //MARK:- Method
    fileprivate func showAlertAddAddress() {
        let alertController = UIAlertController(title: "One more step!", message: "Enter your address!", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Your address(required)"
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self](action) in
            self?.address = alertController.textFields?.first?.text
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func setupCollectionView() {
        cartCollectionView.register(UINib(nibName: String(describing: CartCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    fileprivate func firstSetup() {
        orderDetailViewModel = OrderDetailViewModel()
        orderDetailViewModel.fetchData()
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateUIInCart), name: NSNotification.Name("updateCart"), object: nil)
    }
    fileprivate func reloadData(){
        guard let totalPrice = orderDetailViewModel.getTotalPrice()  else {
            self.showAlert(message: "No Item in Cart")
            self.btnPlaceOrder.isEnabled = false
            return
        }
        lbPrice.text = "$\(totalPrice).00"
    }
    @objc func handleUpdateUIInCart(){
        btnPlaceOrder.isEnabled = true
        orderDetailViewModel.fetchData()
        cartCollectionView.reloadData()
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

