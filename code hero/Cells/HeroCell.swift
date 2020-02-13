//
//  HeroCell.swift
//  code hero
//
//  Created by Thalles Araújo on 12/02/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

import UIKit
import Kingfisher

class HeroCell: UITableViewCell {
    
    @IBOutlet weak var heroThumbnail: UIImageView!
    @IBOutlet weak var lblHeroName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setup(hero: Hero?){
        self.heroThumbnail.kf.setImage(with: URL.init(string: hero?.thumbnail?.image() ?? "loading"), placeholder: UIImage.init(named: "loading"), options: [.forceRefresh], progressBlock: nil, completionHandler: nil)
        lblHeroName.text = hero?.name
        self.heroThumbnail.clipsToBounds = true
        self.heroThumbnail.layer.cornerRadius = self.heroThumbnail.frame.height/2
    }

}
