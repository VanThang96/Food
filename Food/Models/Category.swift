//
//  Category.swift
//  Food
//
//  Created by win on 5/21/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation

struct Category : Decodable {
    var name : String!
    var image : String!
    private enum CodingKeys: String, CodingKey {
        case name
        case image = "link"
    }
}
