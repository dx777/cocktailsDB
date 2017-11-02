//
//  DataService.swift
//  CoctailsDB
//
//  Created by Work on 11/2/17.
//  Copyright © 2017 Work. All rights reserved.
//

import Foundation
import Alamofire
import PKHUD

class DataService {
    
    static let dataService = DataService()
    
    func downloadAllCocktails(completion: @escaping (_ drinks: [Cocktail]) -> Void ){
        
        let url = SERVER_URL + API_PATH + SERVER_ALL_COCTAILS_PATH
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            switch response.result
            {
            case .success:
                if let dict = response.result.value as? Dictionary<String, Any> {
                    
                    var coctails = [Cocktail]()
                    
                    if let drinks = dict["drinks"] as? [Dictionary <String, Any>] {
                        for drink in drinks {
                            let drink = Cocktail(mainDrinkDict: drink)
                            coctails.append(drink)
                        }
                    }
                     completion(coctails)
                }
            case .failure(let error):
                print(error)

            }
        })
    }
    
    func downloadCocktail(id: Int, completion: @escaping (_ drink: Cocktail) -> Void ){
        
        let url = SERVER_URL + API_PATH + LOOKOUP_PATH + String(id)
        HUD.show(.progress)
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
            switch response.result
            {
            case .success:
                if let dict = response.result.value as? Dictionary<String, Any> {
                    
                    var coctails = [Cocktail]()
                    
                    if let drinks = dict["drinks"] as? [Dictionary <String, Any>] {
                        for drink in drinks {
                            let drink = Cocktail(detailsDrink: drink)
                            coctails.append(drink)
                        }
                    }
                    completion(coctails[0])
                }
            case .failure(let error):
                print(error)
                
            }
            HUD.hide()
        })
    }

    
}
