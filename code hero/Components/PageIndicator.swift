//
//  PageIndicator.swift
//  code hero
//
//  Created by Thalles Araújo on 12/02/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

import UIKit

class PageIndicator: UIView {
    
    
    @IBOutlet weak var lblPageNumber: UILabel?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func enable(){
        self.layer.backgroundColor = UIColor.init(hex: "#D42026").cgColor
        self.lblPageNumber?.textColor = UIColor.white
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    
    func disable(){
        self.lblPageNumber?.textColor = UIColor.init(hex: "#D42026")
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.init(hex: "#D42026").cgColor
    }

}
