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
let URL_STORAGE = "Category"
let STORAGE_PROFILE = ""

protocol Reference : class{
    var databaseUser : DatabaseReference { get }
//    var storageProfile : StorageReference { get }
    func databaseSpecificUser (uid :String) -> DatabaseReference
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
    func databaseSpecificUser(uid: String) -> DatabaseReference {
        return databaseUser.child(uid)
    }
    
    //storage Reference
//    let storageRoot = Storage.storage().reference(forURL: URL_STORAGE)
//    var storageProfile: StorageReference {
//        return storageRoot.child(STORAGE_PROFILE)
//    }
//    func storageSpecificProfile(uid: String) -> StorageReference {
//        return storageProfile.child(uid)
//    }
}

