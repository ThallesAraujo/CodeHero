//
//  VCSearch.swift
//  code hero
//
//  Created by Thalles Araújo on 23/05/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

import UIKit

class VCSearch: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, Storyboarded {
    
    @IBOutlet weak var tbvSearch: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var coordinator: Coordinator?
    var requestHandler: RequestHandler?
    
    var heroes: [Hero] = []
    var heroesSearch: [Hero] = []
    var currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.contentView.backgroundColor = .clear
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.contentView.addSubview(view)
        view = blurEffectView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if self.heroesSearch.count > 0{
                return self.heroesSearch.count
            }else{
                return heroes.count
            }
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "heroSearchCell") as? HeroSearchCell{
            if self.heroesSearch.count > 0{
                cell.setup(hero: self.heroesSearch[indexPath.row])
            }else{
                cell.setup(hero: self.heroes[indexPath.row])
            }
            return cell
        }else{
            return HeroSearchCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            self.heroesSearch = []
            self.tbvSearch.reloadData()
        }else{
            self.requestHandler?.fetchData(forViewController: self, completion: {
                self.tbvSearch.reloadData()
            })
        }
    }
    
    
    
    
    private func setupSearchBar(){
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "Pesquisar"
        navigationItem.titleView = searchBar
    }


}
