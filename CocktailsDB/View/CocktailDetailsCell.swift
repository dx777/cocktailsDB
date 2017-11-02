//
//  CocktailDetailsCell.swift
//  CocktailsDB
//
//  Created by Work on 11/2/17.
//  Copyright © 2017 Work. All rights reserved.
//

import UIKit

class CocktailDetailsCell: UITableViewCell {
    
    @IBOutlet weak var column1: UILabel!
    @IBOutlet weak var column2: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configurecell(ingredient: String, measure: String){
        column1.text = ingredient
        column2.text = measure
    }

}
