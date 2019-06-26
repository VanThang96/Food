//
//  DatabaseServices.swift
//  Food
//
//  Created by win on 5/22/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import Firebase

class DatabaseServices {
    static var shareInstance = DatabaseServices()
    
    func Login(key : String , password : String ,onSuccess : @escaping (_ user : NSDictionary?) -> (),onError : @escaping (String?) -> ()) {
        //login
        Ref.sharedInstance.databaseSpecificUser(uid: key).observe(.value, with: { (snapshot) in
            // Get password
            let value = snapshot.value as? NSDictionary
            let passwd = value?["password"] as? String ?? ""
            if passwd == password {
                onSuccess(value)
            }else {
                onError("Name or Password is not correct !")
            }
        }) { (error) in
            onError(error.localizedDescription)
        }
    }
    func Register(key : String , user : UserModel,onSucess : @escaping (String?) -> (), onError : @escaping (String?) -> ()){
        // upload user object in FirebaseDatabase
        let user : [String : Any] = [
            "phone" : user.phone,
            "name" : user.name,
            "password" : user.password
        ]
        //Register
        Ref.sharedInstance.databaseSpecificUser(uid: key).setValue(user) { (error, databaseReference) in
            if let error = error {
                onError("Register fail: \(error).")
            } else {
                onSucess("Register successfully!")
            }
        }
    }
    func fetchCategories(onSuccess : @escaping ([Category]?) -> () , onError : @escaping (String?) -> ()){
        //fetch Menus data
        Ref.sharedInstance.databaseCategories.observeSingleEvent(of: .value, with: {(snapshot) in
            guard let object = snapshot.children.allObjects as? [DataSnapshot] else { return }
            let dict = object.compactMap { $0.value as? [String: Any] }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
                var categories = try JSONDecoder().decode([Category].self, from: jsonData)
                for (index , _) in categories.enumerated() {
                    if index <= 8 {
                        categories[index].uuid = "0\(index + 1)"
                    }else {
                         categories[index].uuid = "\(index + 1)"
                    }
                }
                print(categories)
                onSuccess(categories)
            } catch let error {
                onError(error.localizedDescription)
            }
        }) { (error) in
            onError(error.localizedDescription)
        }
    }
    func fetchFoods(key : String,foodId : @escaping ([String]?) -> (), onSuccess : @escaping ([Food]?) -> () , onError : @escaping (String?) -> ()){
        //fetch Foods data
        Ref.sharedInstance.getFoodsWithMenuId(equal: key).observeSingleEvent(of: .value, with: {(snapshot) in
            guard let object = snapshot.children.allObjects as? [DataSnapshot] else { return }
            let dict = object.compactMap { $0.value as? [String: Any] }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
                let foods = try JSONDecoder().decode([Food].self, from: jsonData)
                onSuccess(foods)
            } catch let error {
                onError(error.localizedDescription)
            }
            var foodIds = [String]()
            for child in snapshot.children {
                let key = (child as AnyObject).key as String
                foodIds.append(key)
            }
            foodId(foodIds)
        }) { (error) in
            onError(error.localizedDescription)
        }
    }
    func uploadRequests(data : Request, uid : String, onSuccess : @escaping (String?) -> (), onError : @escaping (String?) -> ()){
        // upload user object in FirebaseDatabase
        let request : [String : Any] = [
            "phone" : data.phone,
            "name" : data.name,
            "address" : data.address,
            "total" : data.total,
            "foods" : data.foods,
            "status" : data.status
        ]
        Ref.sharedInstance.uploadRequest(uid: uid).setValue(request) { (error, dataref) in
            if let error = error {
                onError("Request order fail: \(error).")
            } else {
                onSuccess("Request order successfully!")
            }
        }
    }
}

