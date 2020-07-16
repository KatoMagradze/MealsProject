//
//  DetailsViewController.swift
//  MealsProject
//
//  Created by Kato on 7/11/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let apiservice = APIService()

    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var detailsTableView: UITableView!
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTextView: UITextView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var shadowBackgroundView: UIView!
    
    var filterCategories = [Filter]()
    
    var categoryDetails: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        shadowBackgroundView.layer.cornerRadius = 150/2
        shadowBackgroundView.layer.shadowColor = UIColor.black.cgColor
        shadowBackgroundView.layer.shadowOpacity = 0.4
        shadowBackgroundView.layer.shadowOffset = .zero
        shadowBackgroundView.layer.shadowRadius = 10
        
        //shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
        shadowBackgroundView.layer.shadowPath = UIBezierPath(roundedRect: shadowBackgroundView.bounds, cornerRadius: shadowBackgroundView.layer.cornerRadius).cgPath
        
        categoryTextView.layer.cornerRadius = 8
        yellowView.layer.cornerRadius = 20
        categoryImageView.layer.cornerRadius = 150/2
        
        categoryDetails?.strCategoryThumb.downloadImage { (image) in
            DispatchQueue.main.async {
                self.categoryImageView.image = image
            }
        }
        
        categoryTextView.text = categoryDetails?.strCategoryDescription
        categoryNameLabel.text = categoryDetails?.strCategory

        
        self.categoriesFilter(filter: categoryDetails!.strCategory)
    }
    
    func categoriesFilter(filter: String) {
        apiservice.fetchFilteredCategories(completion: { (filteredCategories) in
            
            
            for myCategory in filteredCategories.meals {
                self.filterCategories.append(myCategory)
            }
            
            DispatchQueue.main.async {
                self.detailsTableView.reloadData()
            }
        }, category: filter)
    }

}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = detailsTableView.dequeueReusableCell(withIdentifier: DetailsCell.identifier, for: indexPath) as! DetailsCell
        
        cell.foodNameLabel.text = filterCategories[indexPath.row].strMeal
        
        return cell
    }
    
    
}
