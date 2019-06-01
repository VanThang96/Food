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
    
    func fetchData() {
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
    func getOrderDetails() -> [OrderDetail] {
        return orderDetail.map({$0})
    }
    func getCount() -> Int {
        return orderDetail.count
    }
    func getTotalPrice() -> Int? {
        var totalPrice : Int = 0
        guard orderDetail.count != 0 else{
            return nil
        }
        for order in orderDetail {
            totalPrice += Int(order.price!)! * Int(order.quantity!)!
        }
        return totalPrice
    }
    func uploadRequest(uid : String , request : Request , onSuccess : @escaping () -> () , onError : @escaping () -> ()){
        DatabaseServices.shareInstance.uploadRequests(data: request, uid: uid, onSuccess: { (success) in
            print(success!)
            onSuccess()
        }) { (error) in
            print(error!)
            onError()
        }
    }
    func deleteAllOrders(){
        let context = PersistenceService.context
    
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "OrderDetail")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch (let error){
            print ("There was an error: \(error)")
        }
    }
}
