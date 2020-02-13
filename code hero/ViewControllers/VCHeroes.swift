//
//  HeroViewController.swift
//  code hero
//
//  Created by Thalles Araújo on 12/02/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

import UIKit

class VCHeroes: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,Storyboarded {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    @IBOutlet weak var spinnerSearch: UIActivityIndicatorView!
    
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var tbvHeroes: UITableView!
    
    
    @IBOutlet weak var btPrevPage: UIButton!
    @IBOutlet weak var btNextPage: UIButton!
    
    @IBOutlet weak var leftPageIndicator: PageIndicator!
    @IBOutlet weak var middlePageIndicator: PageIndicator!
    @IBOutlet weak var rightPageIndicator: PageIndicator!
    
    var currentPage = 1
    
    let enabledColor = UIColor.init(hex: "#D42026")
    let disabledColor = UIColor.init(hex: "#f5b8ba")
    
    var heroes: [Hero] = []
    var currentPageHeroes: [Hero] = []
    var searchHeroes: [Hero] = []
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if self.searchHeroes.count > 0 && self.searchHeroes.count < 4{
                return self.searchHeroes.count
            }
            return 4
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell") as? HeroCell, self.currentPageHeroes.count > 0{
            cell.setup(hero: self.currentPageHeroes[indexPath.row])
            return cell
        }else{
            return HeroCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }
    
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.spinner.startAnimating()
        self.tbvHeroes.delegate = self
        self.tbvHeroes.dataSource = self
        self.tfSearch.delegate = self
        self.spinnerSearch.isHidden = true
        self.loadHeroes(completion: {
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            self.loadHeroesOfPage()
        })
        
        self.tfSearch.addTarget(self, action: #selector(searchHero(_:)), for: .editingChanged);
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func searchHero(_ sender: Any) {
        
        if let searchTerms = self.tfSearch.text, searchTerms != ""{
            self.spinnerSearch.isHidden = false
            self.spinnerSearch.startAnimating()
            let dispatcher = DispatchGroup()
            
            dispatcher.enter()
            HeroService.getHeroSearch(searchTerms: self.tfSearch.text!, success: { (results) in
                if (results.count > 0){
                    self.searchHeroes = results
                    self.loadHeroesOfPage()
                }
                dispatcher.leave()
            }) { (error) in
                let alert = UIAlertController.init(title: "Ocorreu um problema", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true)
                dispatcher.leave()
            }
            dispatcher.notify(queue: .main, execute: {
                self.spinnerSearch.stopAnimating()
                self.spinnerSearch.isHidden = true
            })
        }else{
            self.searchHeroes = []
            self.loadHeroesOfPage()
        }
        
    }
    
    @IBAction func didTapPreviousPage(_ sender: UIButton) {
        self.currentPage = self.currentPage - 1
        self.loadHeroesOfPage()
        self.enableOrDisableButtons()
    }
    
    @IBAction func didTapNextPage(_ sender: UIButton) {
        self.currentPage = self.currentPage + 1
        self.loadHeroesOfPage()
        self.enableOrDisableButtons()
    }
    
    
    private func enableOrDisableButtons(){
        
        self.btPrevPage.isEnabled = true
        self.btNextPage.isEnabled = true
        self.btPrevPage.setTitleColor(self.enabledColor, for: .normal)
        self.btNextPage.setTitleColor(self.enabledColor, for: .normal)
        
        
        
        if self.currentPage == 1{
            self.btPrevPage.isEnabled = false
            self.btPrevPage.setTitleColor(self.disabledColor, for: .disabled)
        }
        
        if self.searchHeroes.count > 0{
            if self.currentPage == self.searchHeroes.count / 4{
                self.btNextPage.isEnabled = false
                self.btNextPage.setTitleColor(self.disabledColor, for: .disabled)
            }
            
            if self.currentPage * 4 >= self.searchHeroes.count{
                self.btNextPage.isEnabled = false
                self.btNextPage.setTitleColor(self.disabledColor, for: .disabled)
                self.btPrevPage.isEnabled = false
                self.btPrevPage.setTitleColor(self.disabledColor, for: .disabled)
            }
            
        }else{
            if self.currentPage == self.heroes.count / 4{
                self.btNextPage.isEnabled = false
                self.btNextPage.setTitleColor(self.disabledColor, for: .disabled)
            }
        }
        
    }
    
    
    func loadHeroes(completion: @escaping() -> Void){
        
        let dispatcher = DispatchGroup()
        
        dispatcher.enter()
        HeroService.getHeroes(success: { (heroes) in
            self.heroes = heroes
            self.loadHeroesOfPage()
            dispatcher.leave()
        }) { (error) in
            let alert = UIAlertController.init(title: "Ocorreu um problema", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
            dispatcher.leave()
        }
        dispatcher.notify(queue: .main, execute: {
            completion()
        })
        
    }
    
    func loadHeroesOfPage(){
        
        let firstIndex = Int(self.currentPage - 1) * 4
        let lastIndex = Int(self.currentPage * 4) - 1
        self.currentPageHeroes = []
        
        if self.searchHeroes.count > 0{
            
            if lastIndex > self.searchHeroes.count - 1{
                for i in firstIndex...self.searchHeroes.count - 1{
                    self.currentPageHeroes.append(self.searchHeroes[i])
                }
            }else{
                for i in firstIndex...lastIndex{
                    self.currentPageHeroes.append(self.searchHeroes[i])
                }
            }
        }else{
            for i in firstIndex...lastIndex{
                self.currentPageHeroes.append(self.heroes[i])
            }
        }
        
        self.enableOrDisableButtons()
        self.tbvHeroes.reloadData()
        self.activateOrDeactivatePageIndicators()
    }
    
    func activateOrDeactivatePageIndicators(){
        
         self.leftPageIndicator.isHidden = false
         self.rightPageIndicator.isHidden = false
        
        if self.currentPage == 1{
            
            if self.searchHeroes.count > 0 && self.searchHeroes.count < 4{
                self.leftPageIndicator.isHidden = true
                
                self.middlePageIndicator.lblPageNumber?.text = "\(self.currentPage)"
                self.middlePageIndicator.enable()
                
                self.rightPageIndicator.isHidden = true
            }else{
                self.leftPageIndicator.lblPageNumber?.text = "\(self.currentPage)"
                self.leftPageIndicator.enable()
                
                self.middlePageIndicator.lblPageNumber?.text = "\(self.currentPage + 1)"
                self.middlePageIndicator.disable()
                
                self.rightPageIndicator.lblPageNumber?.text = "\(self.currentPage + 2)"
                self.rightPageIndicator.disable()
            }
            
           
        }else if (self.searchHeroes.count > 0 && self.currentPage == self.searchHeroes.count / 4) || self.currentPage == self.heroes.count / 4{
            self.leftPageIndicator.lblPageNumber?.text = "\(self.currentPage - 2)"
            self.leftPageIndicator.disable()
            
            self.middlePageIndicator.lblPageNumber?.text = "\(self.currentPage - 1)"
            self.middlePageIndicator.disable()
            
            self.rightPageIndicator.lblPageNumber?.text = "\(self.currentPage)"
            self.rightPageIndicator.enable()
            
        }else{
            self.leftPageIndicator.lblPageNumber?.text = "\(self.currentPage - 1)"
            self.leftPageIndicator.disable()
            
            self.middlePageIndicator.lblPageNumber?.text = "\(self.currentPage)"
            self.middlePageIndicator.enable()
            
            self.rightPageIndicator.lblPageNumber?.text = "\(self.currentPage + 1)"
            self.rightPageIndicator.disable()
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
