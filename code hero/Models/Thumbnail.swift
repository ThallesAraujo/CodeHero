//
//  Thumbnail.swift
//  code hero
//
//  Created by Thalles Araújo on 12/02/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

import Foundation
import ObjectMapper

infix operator <-

class Thumbnail: Mappable{
    
    var path: String = ""
    var mimetype: String = ""
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        path <- map["path"]
        mimetype <- map["extension"]
    }
    
    func image() -> String{
        return self.path + "/portrait_xlarge." + self.mimetype
    }
    
    
}
