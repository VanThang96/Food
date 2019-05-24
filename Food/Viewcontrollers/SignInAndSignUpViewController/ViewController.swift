//
//  ViewController.swift
//  Food
//
//  Created by win on 5/19/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    //MARK:- IBOutlet
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!

    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLayoutSubviews() {
        setupUI()
    }
    
    //MARK:- Method
    fileprivate func setupUI(){
        btnSignIn.makeCornerAndGradient(startColor: UIColor(named: "#FF8C2B")!, endColor: UIColor(named: "#FF6322")!)
        btnSignUp.makeCornerAndBorderButton(color: UIColor(named: "#FF8C2B")!)
    }
}

