//
//  ViewController.swift
//  CoctailsDB
//
//  Created by Work on 11/2/17.
//  Copyright © 2017 Work. All rights reserved.
//

import UIKit
import PKHUD

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate var cockatils = [Cocktail]()
    fileprivate var filteredCockatils = [Cocktail]()
    fileprivate var insearchmode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.returnKeyType = UIReturnKeyType.done
        DataService.dataService.downloadAllCocktails { [weak self] (drinks) in
            self?.cockatils = drinks
            self?.collectionView.reloadData()
        }
        setCollectionViewLayout()

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: "detailsVC") as? DetailsVC {
            let drink: Cocktail?

            switch insearchmode {
            case true:
                drink = filteredCockatils[indexPath.row]
            case false:
                drink = cockatils[indexPath.row]
                
            }
            
            if let id = drink?.id {
                HUD.show(.progress)
                DataService.dataService.downloadCocktail(id: id) { [weak self] (drink) in
                    HUD.hide()
                    detailsVC.currentCocktail = drink
                    self?.navigationController?.pushViewController(detailsVC, animated: true)
                }
            }

        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cocktailMainCell", for: indexPath) as? CoctailCollectionCell {
            
            let drink: Cocktail?
            
            switch insearchmode {
            case true:
                drink = filteredCockatils[indexPath.row]
            case false:
                drink = cockatils[indexPath.row]

            }
            
            if let cocktail = drink {
                cell.configurecell(drink: cocktail)
            }
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch insearchmode {
        case true:
            return filteredCockatils.count
        case false:
            return cockatils.count
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        
        if searchBar.text == nil || searchBar.text == "" {
            insearchmode = false
            view.endEditing(true)
        } else {
            insearchmode = true
            if let text = searchBar.text {
                filteredCockatils = cockatils.filter({($0.title?.localizedCaseInsensitiveContains(text))!})
            }
        }
        collectionView.reloadData()

    }
    
    func setCollectionViewLayout() {
        let columnLayout = ColumnFlowLayout(
            cellsPerRow: 3,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        )
        collectionView?.collectionViewLayout = columnLayout
    }

}

