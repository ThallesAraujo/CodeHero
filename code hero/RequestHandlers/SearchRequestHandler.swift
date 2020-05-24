//
//  SearchRequestHandler.swift
//  code hero
//
//  Created by Thalles Araújo on 24/05/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

import Foundation
import UIKit

class SearchRequestHandler: RequestHandler {
    
    func fetchData(forViewController vc: UIViewController, completion: @escaping () -> Void) {
        
        if let vc = vc as? VCSearch{
            let dispatcher = DispatchGroup()
            dispatcher.enter()
            HeroService.getHeroSearch(searchTerms: vc.searchBar.text!, success: { (heroes) in
                vc.heroesSearch = heroes
                print("SearchTerms \(vc.searchBar.text!)")
                dispatcher.leave()
            }) { (error) in
                let alert = UIAlertController.init(title: "Ocorreu um problema", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                vc.present(alert, animated: true)
                dispatcher.leave()
            }
            dispatcher.notify(queue: .main, execute: {
                completion()
            })
        }
    
    
    }
}
