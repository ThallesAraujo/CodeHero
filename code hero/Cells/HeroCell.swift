//
//  HeroCell.swift
//  code hero
//
//  Created by Thalles Araújo on 12/02/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

import UIKit
import Kingfisher

class HeroCell: UICollectionViewCell {
    
    @IBOutlet weak var heroThumbnail: UIImageView!
    @IBOutlet weak var lblHeroName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundCorners(corners: [.allCorners], radius: 20.0)
    }

    
    func setup(hero: Hero?){
        self.heroThumbnail.kf.setImage(with: URL.init(string: hero?.thumbnail?.image() ?? "loading"), placeholder: UIImage.init(named: "loading"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
        lblHeroName.text = hero?.name
        self.heroThumbnail.clipsToBounds = true
        self.heroThumbnail.roundCorners(corners: [ .allCorners], radius: 15.0)
    }

}
