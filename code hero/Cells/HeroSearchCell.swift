//
//  HeroSearchCell.swift
//  code hero
//
//  Created by Thalles Araújo on 23/05/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

import UIKit
import Kingfisher

class HeroSearchCell: UITableViewCell {
    
    @IBOutlet weak var lblHeroName: UILabel!
    @IBOutlet weak var heroImage: UIImageView!

    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(hero: Hero?){
        self.heroImage.kf.setImage(with: URL.init(string: hero?.thumbnail?.image() ?? "loading"), placeholder: UIImage.init(named: "loading"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
        self.heroImage.clipsToBounds = true
        self.heroImage.roundCorners(corners: [ .allCorners], radius: 15.0)
        self.lblHeroName.text = hero?.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
