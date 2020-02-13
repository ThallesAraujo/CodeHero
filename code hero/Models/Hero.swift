//
//  Hero.swift
//  code hero
//
//  Created by Thalles Araújo on 12/02/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

import Foundation
import ObjectMapper

infix operator <-

class Hero: Mappable {
    
    
    var id: Int = 0
    var name: String = ""
    var description: String = ""
    var thumbnail: Thumbnail?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        thumbnail <- map["thumbnail"]
    }
    
    
    
}
