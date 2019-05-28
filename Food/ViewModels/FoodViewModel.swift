//
//  FoodViewModel.swift
//  Food
//
//  Created by win on 5/22/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation

class FoodViewModel {
    var foods = [Food]()
    var foodIds = [String]()
    
    func fetchFoods(menuId : String,onSuccess : @escaping () -> () , onError : @escaping (String?) -> ()){
        DatabaseServices.shareInstance.fetchFoods(key: menuId, foodId: { [weak self](foodIds) in
            self?.foodIds = foodIds!
            onSuccess()
        }, onSuccess: { [weak self](foods) in
            self?.foods = foods!
            onSuccess()
        }) { (error) in
            onError(error)
        }
    }
    func getFood(atIndex : Int) -> Food {
        return foods[atIndex]
    }
    func getCount() -> Int{
        return foods.count
    }
    func getFoodId(atIndex : Int) -> String {
        return foodIds[atIndex]
    }
}
