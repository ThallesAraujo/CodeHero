//
//  ConfigScheme.swift
//  swift-issues
//
//  Created by Thalles Araújo on 26/01/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

import Foundation
class ConfigScheme{
    static var MARVEL_URL: String  {
        get {
            return ConfigScheme.valueForKey("MARVEL_URL")
        }
    }
    
    static var API_KEY_URL: String  {
        get {
            return ConfigScheme.valueForKey("API_KEY_URL")
        }
    }
    
    static var PUBLIC_KEY: String  {
        get {
            return ConfigScheme.valueForKey("PUBLIC_KEY")
        }
    }
    
    static var PRIVATE_KEY: String  {
        get {
            return ConfigScheme.valueForKey("PRIVATE_KEY")
        }
    }
    
    static func valueForKey(_ key: String, plistName: String = "Info") -> String {
        if let path = Bundle.main.path(forResource: plistName, ofType: "plist") {
            if let dic = NSDictionary(contentsOfFile: path) {
                return dic[key] as? String ?? ""
            }
        }
        
        return ""
    }
    
}
