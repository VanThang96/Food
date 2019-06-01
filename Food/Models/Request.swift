//
//  Request.swift
//  Food
//
//  Created by win on 6/1/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation

struct Request {
    var phone : String
    var name : String
    var address : String
    var total : String
    var foods : String
    
    init(phone : String , name : String , address : String , total :String , foods : String) {
        self.phone = phone
        self.name = name
        self.address = address
        self.total = total
        self.foods = foods
    }
}
