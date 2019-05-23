//
//  SignUpViewController.swift
//  Food
//
//  Created by win on 5/20/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit
import SVProgressHUD

class SignUpViewController: UIViewController {
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var userViewModel : UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userViewModel = UserViewModel()
        setupNavigationBar()
    }
    override func viewDidLayoutSubviews() {
        setupUI()
    }
    @IBAction func dismisssViewController(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func handleCreateAccountAction(_ sender: UIButton) {
        userViewModel.infor(phone: txtPhoneNumber.text, name: txtFullName.text, password: txtPassword.text)
        if let checkPhoneNumber = userViewModel.checkPhoneNumber() {
            showAlert(message: checkPhoneNumber)
        }else if let checkFullname = userViewModel.checkFullName() {
            showAlert(message: checkFullname)
        }else if let checkPassword = userViewModel.checkPassword(){
            showAlert(message: checkPassword)
        }else {
            SVProgressHUD.setDefaultStyle(.custom)
            SVProgressHUD.setDefaultMaskType(.custom)
            SVProgressHUD.setBackgroundColor(UIColor.white)
            SVProgressHUD.setForegroundColor(UIColor(named: "HUB_foreground")!)
            SVProgressHUD.setBackgroundLayerColor(UIColor(named: "HUB_layer")!)
            SVProgressHUD.show()
            userViewModel.Register(onSucess: { [weak self](sucsess) in
                print(sucsess!)
                SVProgressHUD.dismiss()
                let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let homeTabbar = homeStoryboard.instantiateInitialViewController()
                self?.present(homeTabbar!, animated: true, completion: nil)
            }) { [weak self](error) in
                SVProgressHUD.dismiss()
                self?.showAlert(message: error!)
            }
        }
    }
    fileprivate func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
    }
    fileprivate func setupUI(){
        txtPhoneNumber.addLeftView(image: "icon_phone", tintColor: .lightGray)
        txtFullName.addLeftView(image: "icon_person", tintColor: .lightGray)
        txtPassword.addLeftView(image: "icon_password", tintColor: .lightGray)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleShowOrHiddenPassword))
        txtPassword.addShowAndHidePassword(tapGesture: tapGesture, tintColor: .lightGray)
        
        btnSignUp.makeCornerAndBorderButton(color: UIColor(named: "#FF8C2B")!)
    }
    @objc func handleShowOrHiddenPassword(){
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleShowOrHiddenPassword))
        txtPassword.addShowAndHidePassword(tapGesture: tapGesture, tintColor: .lightGray)
    }
}
