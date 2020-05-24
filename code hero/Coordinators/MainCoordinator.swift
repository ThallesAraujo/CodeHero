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
        vc.requestHandler = MainRequestHandler()
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToHeroSearch(_ initialData: [Hero]){
        let vc = VCSearch.instantiate()
        vc.coordinator = self
        vc.heroes = initialData
        vc.requestHandler = SearchRequestHandler()
        navigationController.viewControllers[0].present(vc, animated: true, completion: {})
    }
    
    func goToWHOWebsite(){
        UIApplication.shared.open(URL(string: "https://www.who.int/health-topics/coronavirus")!, options: [:]) { _ in }
    }
    

}
