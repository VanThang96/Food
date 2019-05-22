//
//  UserViewModel.swift
//  Food
//
//  Created by win on 5/21/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

class UserViewModel {
    var user = UserModel()
    func infor(phone : String?, name : String?, password : String? ){
        self.user.phone     = phone
        self.user.name      = name
        self.user.password  = password
    }
    func checkPhoneNumber() -> String?{
        if user.phone.count < 10 && user.phone.count >= 0{
            return "Phone number must be least 10 numbers!"
        }
        return nil
    }
    func checkFullName() ->String?{
        if user.phone.count == 0 {
            return "Fullname must be not empty!"
        }
        return nil
    }
    func checkPassword() -> String?{
        if user.password.count < 8 && user.password.count >= 0 {
            return "Password must be least 8 characters!"
        }
        return nil
    }
    func Login(onSuccess : @escaping () -> (),onError : @escaping (String?) -> ()) {
        DatabaseServices.shareInstance.Login(key: self.user.phone, password: self.user.password, onSuccess: {
            onSuccess()
        }) { (error) in
            onError(error)
        }
    }
    func Register(onSucess : @escaping (String?) -> (), onError : @escaping (String?) -> ()){
        DatabaseServices.shareInstance.Register(key: self.user.phone, user: user, onSucess: { (success) in
            onSucess(success!)
        }) { (error) in
            onError(error)
        }
    }
}
