//
//  CoctailCell.swift
//  CoctailsDB
//
//  Created by Work on 11/2/17.
//  Copyright © 2017 Work. All rights reserved.
//

import UIKit
import Kingfisher

class CoctailCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var thumbIMg: UIImageView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configurecell(drink: Cocktail){
        nameLbl.text = drink.title
        if let url = drink.thumbUrl {
            thumbIMg.kf.indicatorType = .activity
            thumbIMg.kf.setImage(with: URL(string: url))
        }
    }
    
}
