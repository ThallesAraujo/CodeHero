//
//  MainRequestHandler.swift
//  code hero
//
//  Created by Thalles Araújo on 24/05/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

import Foundation
import UIKit
class MainRequestHandler: RequestHandler {
    
    func fetchData(forViewController vc: UIViewController, completion: @escaping () -> Void) {
        
        let dispatcher = DispatchGroup()
        
        dispatcher.enter()
        HeroService.getHeroes(success: { (heroes) in
            if let vc = vc as? VCHeroes{
                vc.heroes = heroes
            }
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
