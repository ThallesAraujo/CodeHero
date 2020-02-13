//
//  MainCoordinator.swift
//  swift-issues
//
//  Created by Thalles Araújo on 08/02/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = VCHeroes.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
//    func goToHero(hero: Hero){
//        let vc = VCHero.instantiate()
//        vc.hero = hero
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: true)
//    }

}
