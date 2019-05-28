//
//  OrderDetail+CoreDataProperties.swift
//  Food
//
//  Created by win on 5/26/19.
//  Copyright © 2019 win. All rights reserved.
//
//

import Foundation
import CoreData


extension OrderDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderDetail> {
        return NSFetchRequest<OrderDetail>(entityName: "OrderDetail")
    }

    @NSManaged public var discount: String?
    @NSManaged public var price: String?
    @NSManaged public var productId: String?
    @NSManaged public var productName: String?
    @NSManaged public var quantity: String?

}
