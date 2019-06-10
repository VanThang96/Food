//
//  Category.swift
//  Food
//
//  Created by win on 5/21/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation

struct Category  {
    var uuid : String = ""
    var name : String
    var image : String
    init(uuid : String = "", name : String = "",  image  : String = "") {
        self.uuid = uuid
        self.name = name
        self.image = image
    }
}
extension Category : Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case image = "link"
    }
    init(from decoder : Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let image = try container.decode(String.self, forKey: .image)
        
        self.init(name: name, image: image)
    }
}
