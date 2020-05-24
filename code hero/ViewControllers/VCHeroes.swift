//
//  HeroViewController.swift
//  code hero
//
//  Created by Thalles Araújo on 12/02/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

import UIKit

class VCHeroes: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,Storyboarded {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tbvHeroes: UICollectionView!
    var heroes: [Hero] = []
    
    weak var coordinator: MainCoordinator?
    var requestHandler: RequestHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.spinner.startAnimating()
        self.loadHeroes(completion: {
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            self.tbvHeroes.delegate = self
            self.tbvHeroes.dataSource = self
            self.tbvHeroes.reloadData()
        })
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as? HeroCell{
            cell.setup(hero: self.heroes[indexPath.row])
            return cell
        }else{
            return HeroCell()
        }
    }
    
    func loadHeroes(completion: @escaping() -> Void){
        self.requestHandler?.fetchData(forViewController: self, completion: completion)
    }
    
    @IBAction func goToSearch(_ sender: Any) {
        if let coordinator = self.coordinator{
            coordinator.goToHeroSearch(self.heroes)
        }
    }
    
    
    @IBAction func goToSeeMore(_ sender: Any) {
        if let coordinator = self.coordinator{
            coordinator.goToHeroSearch(self.heroes)
        }
    }
    
    
    @IBAction func goToWhoWebsite(_ sender: Any) {
        if let coordinator = self.coordinator{
            coordinator.goToWHOWebsite()
        }
    }
    
}
