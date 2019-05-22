//
//  API.swift
//  Food
//
//  Created by win on 5/21/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import Firebase

let REF_USER = "Users"
let REF_CATEGORY = "Category"
let REF_FOOD = "Food"
let REF_FOOD_MENUID = "menuId"
let URL_STORAGE = ""
let STORAGE_PROFILE = ""

protocol Reference : class{
    var databaseUser : DatabaseReference { get }
    var databaseCategories : DatabaseReference { get }
    var databaseFoods : DatabaseQuery { get }
//    var storageProfile : StorageReference { get }
    func databaseSpecificUser (uid :String) -> DatabaseReference
    func getFoodsWithMenuId(equal Id: String) -> DatabaseQuery
//    func storageSpecificProfile (uid : String) -> StorageReference
}
class Ref : Reference {
    static let sharedInstance = Ref()
    
    let databaseRoot = Database.database().reference()
    var databaseUser: DatabaseReference {
        return databaseRoot.child(REF_USER)
    }
    var databaseCategories: DatabaseReference {
        return databaseRoot.child(REF_CATEGORY)
    }
    var databaseFoods: DatabaseQuery {
        return databaseRoot.child(REF_FOOD).queryOrdered(byChild: REF_FOOD_MENUID)
    }
    func databaseSpecificUser(uid: String) -> DatabaseReference {
        return databaseUser.child(uid)
    }
    func getFoodsWithMenuId(equal Id: String) -> DatabaseQuery {
        return databaseFoods.queryEqual(toValue:Id)
    }
    //storage Reference
    /*let storageRoot = Storage.storage().reference(forURL: URL_STORAGE)
    var storageProfile: StorageReference {
        return storageRoot.child(STORAGE_PROFILE)
    }
    func storageSpecificProfile(uid: String) -> StorageReference {
        return storageProfile.child(uid)
    }*/
}

