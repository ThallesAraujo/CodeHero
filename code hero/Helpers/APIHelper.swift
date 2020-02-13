//
//  APIHelper.swift
//  swift-issues
//
//  Created by Thalles Araújo on 26/01/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG
enum APIHelper: String{
    
    case HEROES =  "characters?"
    
    case HERO = "characters/%@"
    
    case HERO_SEARCH = "characters?nameStartsWith=%@&"
    
    
    func getURL(_ parameters: [String] = []) -> URL {
        let host = ConfigScheme.MARVEL_URL
        let publicKey = ConfigScheme.PUBLIC_KEY
        let privateKey = ConfigScheme.PRIVATE_KEY
        
        var service = self.rawValue
        if parameters.count > 0 {
            service = String(format: self.rawValue, arguments: parameters)
        }
        let timestamp = NSDate().timeIntervalSince1970
        
        var hash = "\(timestamp)" + privateKey + publicKey
        hash = hash.md5()
        
        let urlString = host + service + "apikey=\(publicKey)" + "&ts=\(timestamp)" + "&hash=\(hash)"
       
        return URL(string: urlString)!
    }
    
    
    
}
