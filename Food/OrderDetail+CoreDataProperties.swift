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


extension OrderDetail : Encodable{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderDetail> {
        return NSFetchRequest<OrderDetail>(entityName: "OrderDetail")
    }

    @NSManaged public var discount: String?
    @NSManaged public var price: String?
    @NSManaged public var productId: String?
    @NSManaged public var productName: String?
    @NSManaged public var quantity: String?
    
    private enum CodingKeys : String ,CodingKey {
        case discount
        case price
        case productId
        case productName
        case quantity
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(discount, forKey: .discount)
        try container.encode(price, forKey: .price)
        try container.encode(productId, forKey: .productId)
        try container.encode(productName, forKey: .productName)
        try container.encode(quantity, forKey: .quantity)
    }
}
