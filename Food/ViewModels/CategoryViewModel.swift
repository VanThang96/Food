//
//  CategoryViewModel.swift
//  Food
//
//  Created by win on 5/21/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import Firebase

class CategoryViewModel {
    var categories = [Category]()
    func fetchAllCategoty(onSuccess : @escaping () -> () , onError : @escaping (String?) -> ()){
        DatabaseServices.shareInstance.fetchAllCategoty(onSuccess: { (categories) in
            self.categories = categories!
            onSuccess()
        }) { (error) in
            onError(error)
        }
    }
    func getAllCategories() -> [Category] {
        return categories
    }
    func getCategory(atIndex : Int) -> Category {
        return categories[atIndex]
    }
    func getCount() -> Int{
        return categories.count
    }
    
}
