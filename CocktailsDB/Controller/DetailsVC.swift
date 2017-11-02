//
//  DetailsVC.swift
//  CocktailsDB
//
//  Created by Work on 11/2/17.
//  Copyright © 2017 Work. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var currentCocktail: Cocktail?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Dynamic sizing for the header view
        if let footerView = tableView.tableFooterView {
            let height = footerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
            var footerFrame = footerView.frame
            
            // If we don't have this check, viewDidLayoutSubviews() will get
            // repeatedly, causing the app to hang.
            if height != footerFrame.size.height {
                footerFrame.size.height = height
                footerView.frame = footerFrame
                tableView.tableFooterView = footerView
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        titleLabel.text = currentCocktail?.title
        if let url = currentCocktail?.thumbUrl {
            thumbImg.kf.indicatorType = .activity
            thumbImg.kf.setImage(with: URL(string: url))
        }
        setupFooter()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let ingredientsCount = currentCocktail?.ingredientsArr?.count {
            return ingredientsCount
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as? CocktailDetailsCell {
            if let ingredient = currentCocktail?.ingredientsArr?[indexPath.row] {
                if let measure = currentCocktail?.measuresArr?[indexPath.row] {
                    cell.configurecell(ingredient: ingredient, measure: measure)
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    func setupFooter() {
        let footer = tableView.tableFooterView as? CocktailDetailTableViewFooter
        footer?.instructions.text = currentCocktail?.instructions
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
