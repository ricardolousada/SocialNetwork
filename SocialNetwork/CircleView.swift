//
//  CircleView.swift
//  SocialNetwork
//
//  Created by Ricardo Lousada on 23/10/17.
//  Copyright © 2017 IT-4-ALL. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    
    override func layoutSubviews() {
  
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width/2

    
    }
    
    
    
}
