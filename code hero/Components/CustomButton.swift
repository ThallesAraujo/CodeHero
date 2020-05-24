//
//  CustomButton.swift
//  code hero
//
//  Created by Thalles Araújo on 23/05/20.
//  Copyright © 2020 Thalles Araújo. All rights reserved.
//

import UIKit

class CustomButton: UIButton{
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundCorners(corners: [.allCorners], radius: 30.0)
    }
    
}
