//
//  ViewController.swift
//  MealsProject
//
//  Created by Kato on 7/7/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let apiservice = APIService()
    
    var randomMeal = [Meal]()
    var allCategories = [Category]()
    
    var resultHasImage = false
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        apiservice.fetchAllCategories { (allCategories) in
            
            for category in allCategories.categories {
                self.allCategories.append(category)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        //       while !resultHasImage {
        apiservice.fetchRandomMeal { (randomMeal) in
            
            for meal in randomMeal.meals {
                self.randomMeal.append(meal)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            //                if self.randomMeal.count > 0 {
            //                    self.resultHasImage = true
            //                }
            //print(self.randomMeal)
        }
        //}
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier, for: indexPath) as! HeaderCell
            
            if randomMeal.count > 0 {
                randomMeal[0].strMealThumb!.downloadImage { (image) in
                    DispatchQueue.main.async {
                        cell.randomMealImageView.image = image
                    }
                }
                cell.randomMealNameLabel.text = randomMeal[indexPath.row].strMeal
            }
            else {
                cell.randomMealNameLabel.text = "Error loading meal"
            }
            cell.randomMealImageView.layer.cornerRadius = 20
            cell.gradientView.layer.cornerRadius = 20
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesCell.identifier, for: indexPath) as! CategoriesCell
        
        allCategories[indexPath.row].strCategoryThumb.downloadImage { (image) in
            DispatchQueue.main.async {
                cell.categoryImageView.image = image
            }
        }
        
        cell.categoryNameLabel.text = allCategories[indexPath.row].strCategory
        cell.categoryDescriptionLabel.text = allCategories[indexPath.row].strCategoryDescription
        
        cell.categoryImageView.layer.cornerRadius = 100/2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != 0 {
            selectedIndex = indexPath.row
            
            performSegue(withIdentifier: "details_segue", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! DetailsViewController
        vc.categoryDetails = allCategories[selectedIndex]
        
    }
    
}

