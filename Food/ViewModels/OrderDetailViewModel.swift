//
//  OrderDetailViewModel.swift
//  Food
//
//  Created by win on 5/26/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import CoreData

class OrderDetailViewModel {
    var orderDetail = [OrderDetail]()
    var totalPrice : Int = 0
    
    init() {
        let fetchRequest : NSFetchRequest<OrderDetail> = OrderDetail.fetchRequest()
        
        do {
            let orderDetails = try PersistenceService.context.fetch(fetchRequest)
            self.orderDetail = orderDetails
        }catch (let error) {
            fatalError(error.localizedDescription)
        }
    }
    
    func getOrderDetail(atIndex : Int) -> OrderDetail {
        return orderDetail[atIndex]
    }
    func getCount() -> Int {
        return orderDetail.count
    }
    func getTotalPrice() -> Int? {
        guard orderDetail.count != 0 else{
            return nil
        }
        for order in orderDetail {
            totalPrice += Int(order.price!)! * Int(order.quantity!)!
        }
        return totalPrice
    }
}
