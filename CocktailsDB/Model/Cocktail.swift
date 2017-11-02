//
//  Coctail.swift
//  CoctailsDB
//
//  Created by Work on 11/2/17.
//  Copyright © 2017 Work. All rights reserved.
//

import Foundation

struct Cocktail {
    
     var id: Int?
     var title: String?
     var glass: String?
     var instructions: String?
     var thumbUrl: String?
     var ingredientsArr: [String?]?
     var measuresArr: [String?]?

    
    init(mainDrinkDict: Dictionary<String, Any>) {
        
        if let title = mainDrinkDict["strDrink"] as? String {
            self.title = title
        }
        
        if let id = mainDrinkDict["idDrink"] as? String {
            self.id = Int(id)
        }
        
        if let thumbUrl = mainDrinkDict["strDrinkThumb"] as? String {
            self.thumbUrl = thumbUrl
        }
    }
    
    init(detailsDrink: Dictionary<String, Any>) {
        
        if let title = detailsDrink["strDrink"] as? String {
            self.title = title
        }
        
        if let id = detailsDrink["idDrink"] as? String {
            self.id = Int(id)
        }
        
        if let thumbUrl = detailsDrink["strDrinkThumb"] as? String {
            self.thumbUrl = thumbUrl
        }
        
        if let glass = detailsDrink["strGlass"] as? String {
            self.glass = glass
        }
        
        if let instructions = detailsDrink["strInstructions"] as? String {
            self.instructions = instructions
        }
        
        self.ingredientsArr = [String]()
        self.measuresArr = [String]()
        var i = 1
        while i <= 15 {
            if let ingredient = detailsDrink["strIngredient\(String(i))"] as? String {
                if !ingredient.isEmpty {
                    self.ingredientsArr?.append(ingredient)
                }
            }
            if let measure = detailsDrink["strMeasure\(String(i))"] as? String {
                if !measure.isEmpty {
                    self.measuresArr?.append(measure)
                }
            }
            i = i + 1
        }
        
    }
    
    

}
