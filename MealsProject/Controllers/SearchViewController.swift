//
//  SearchViewController.swift
//  MealsProject
//
//  Created by Kato on 7/9/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let apiservice = APIService()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchedMeal = [Meal]()
    var filteredSearchedMeal = [Meal]()
    
    var filterSet = false
    
    let searchImage = UIImage(named: "search")
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        tableView.isHidden = true
        
        //self.setUpSearchIcon()
        
    }
    
    func setUpSearchIcon() {
        let imageView = UIImageView(image: searchImage!)
        imageView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        view.addSubview(imageView)
    }
    
    func searchedFood(searched: String) {
        
        apiservice.fetchSearchedMeals(completion: { (searchedMeals) in
            
            
            for search in searchedMeals.meals {
                self.searchedMeal.append(search)
            }
            //print(searchedMeals)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, search: searched)
    }
    
    
    func filterMeals(searchText: String) {
        if self.filterSet {
            self.filteredSearchedMeal.removeAll()
            for i in self.searchedMeal {
                if (i.strMeal!.contains(searchText)) {
                    self.filteredSearchedMeal.append(i)
                }
            }
        }
        self.tableView.reloadData()
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cellCount = 0
        if self.filterSet
        {
            cellCount = self.filteredSearchedMeal.count
        }
        else
        {
            cellCount = self.searchedMeal.count
        }
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        
        if self.filterSet {
            
            filteredSearchedMeal[indexPath.row].strMealThumb?.downloadImage(completion: { (image) in
                DispatchQueue.main.async {
                    cell.searchedMealImageView.image = image
                }
            })
            
            cell.searchedMealName.text = filteredSearchedMeal[indexPath.row].strMeal
            cell.searchedMealCategory.text = "Category: \(String(filteredSearchedMeal[indexPath.row].strCategory!))"
            cell.searchedMealArea.text = "Area: \(String(filteredSearchedMeal[indexPath.row].strArea!))"
            
            cell.searchedMealImageView.layer.cornerRadius = 10
            
        }
        else
        {
            
            searchedMeal[indexPath.row].strMealThumb?.downloadImage(completion: { (image) in
                DispatchQueue.main.async {
                    cell.searchedMealImageView.image = image
                }
            })
            
            cell.searchedMealName.text = searchedMeal[indexPath.row].strMeal
            cell.searchedMealCategory.text = searchedMeal[indexPath.row].strCategory
            cell.searchedMealArea.text = searchedMeal[indexPath.row].strArea
            
            cell.searchedMealImageView.layer.cornerRadius = 10
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "search_details_segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MealDetailsViewController
        vc.id = filteredSearchedMeal[selectedIndex].idMeal!
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 2 {
            filterSet = true
            tableView.isHidden = false
            self.searchedMeal.removeAll()
            self.searchedFood(searched: searchText)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.filterMeals(searchText: searchText)
            }
            
        }
        else
        {
            filterSet = false
            self.searchedMeal.removeAll()
            tableView.isHidden = true
            //self.searchedFood(searched: "")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.filterMeals(searchText: searchText)
            }
        }
        
    }
    
}
