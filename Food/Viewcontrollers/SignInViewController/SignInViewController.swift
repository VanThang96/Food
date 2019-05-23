//
//  SignInViewController.swift
//  Food
//
//  Created by win on 5/20/19.
//  Copyright © 2019 win. All rights reserved.
//

import UIKit
import SVProgressHUD

class SignInViewController: UIViewController {
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    
    var userViewModel : UserViewModel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        userViewModel = UserViewModel()
    }
    override func viewDidLayoutSubviews() {
        setupUI()
    }
    @IBAction func dismissViewController(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func handleLoginAction(_ sender: UIButton) {
        userViewModel.infor(phone: txtPhoneNumber.text, name: nil, password: txtPassword.text)
        if let checkPhoneNumber = userViewModel.checkPhoneNumber() {
            showAlert(message: checkPhoneNumber)
        }else if let checkPassword = userViewModel.checkPassword(){
            showAlert(message: checkPassword)
        }else {
            SVProgressHUD.setDefaultStyle(.custom)
            SVProgressHUD.setDefaultMaskType(.custom)
            SVProgressHUD.setBackgroundColor(UIColor.white)
            SVProgressHUD.setForegroundColor(UIColor(named: "HUB_foreground")!)
            SVProgressHUD.setBackgroundLayerColor(UIColor(named: "HUB_layer")!)
            SVProgressHUD.show()
            userViewModel.Login(onSuccess: {[weak self] in
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
    @objc func handleShowOrHiddenPassword(){
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleShowOrHiddenPassword))
        txtPassword.addShowAndHidePassword(tapGesture: tapGesture, tintColor: .lightGray)
    }
    fileprivate func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    fileprivate func setupUI(){
        txtPhoneNumber.addLeftView(image: "icon_phone", tintColor: .lightGray)
        txtPassword.addLeftView(image: "icon_password", tintColor: .lightGray)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleShowOrHiddenPassword))
        txtPassword.addShowAndHidePassword(tapGesture: tapGesture, tintColor: .lightGray)
        btnSignIn.makeCornerAndGradient(startColor: UIColor(named: "#FF8C2B")!, endColor: UIColor(named: "#FF6322")!)
    }
}
