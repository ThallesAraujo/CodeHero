//
//  HeroService.swift
//  code hero
//
//  Created by Thalles Araújo on 11/02/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

//@see -> https://developer.marvel.com/docs#!/public/getCreatorCollection_get_0

import Foundation
import Alamofire
import ObjectMapper

class HeroService{
    
    class func getHeroes(success: @escaping (_ heroes: [Hero]) -> Void, failure: @escaping (_ error: String) -> Void){
        
        Network.request(url: APIHelper.HEROES.getURL(), method: .get, completion: { (response) in
            guard let statusCode = response.response?.statusCode, statusCode == 200 else {
                failure("Falha ao buscar dados")
                return
            }
            
            guard let result = response.result.value as? [String:Any], let json = result["data"] as? [String: Any], let list = json["results"] as? [[String:Any]] else{
                failure("Erro ao ler JSON")
                return
            }
            
            let heroes = Mapper<Hero>().mapArray(JSONArray: list)
            success(heroes)
        }, noNetworkCompletion: failure)
    }
    
    class func getHeroSearch(searchTerms: String, success: @escaping (_ heroes: [Hero]) -> Void, failure: @escaping (_ error: String) -> Void){
        
        Network.request(url: APIHelper.HERO_SEARCH.getURL([String.init(format:"%@",searchTerms.replacingOccurrences(of: " ", with: "%20"))]), method: .get, completion: { (response) in
            guard let statusCode = response.response?.statusCode, statusCode == 200 else {
                failure("Falha ao buscar dados")
                return
            }
            
            guard let result = response.result.value as? [String:Any], let json = result["data"] as? [String: Any], let list = json["results"] as? [[String:Any]] else{
                failure("Erro ao ler JSON")
                return
            }
            
            let heroes = Mapper<Hero>().mapArray(JSONArray: list)
            success(heroes)
        }, noNetworkCompletion: failure)
    }
    
    
}
