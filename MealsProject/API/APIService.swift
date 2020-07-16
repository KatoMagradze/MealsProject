//
//  APIService.swift
//  MealsProject
//
//  Created by Kato on 7/7/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation

class APIService {
    
    func fetchRandomMeal(completion: @escaping (RandomMeal) -> ()) {
        
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let randomMeal = try decoder.decode(RandomMeal.self, from: data)
                
                completion(randomMeal)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchAllCategories(completion: @escaping (AllCategories) -> ()) {
        
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let categories = try decoder.decode(AllCategories.self, from: data)
                
                completion(categories)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchAllAreas(completion: @escaping (AllAreas) -> ()) {
        
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/list.php?a=list") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let areas = try decoder.decode(AllAreas.self, from: data)
                
                completion(areas)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchFilteredAreas(completion: @escaping (FilteredAreas) -> (), area: String) {
        
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(area)") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let filteredArea = try decoder.decode(FilteredAreas.self, from: data)
                
                completion(filteredArea)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchSearchedMeals(completion: @escaping (SearchResults) -> (), search: String) {
        
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(search)") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let searchedMeal = try decoder.decode(SearchResults.self, from: data)
                
                completion(searchedMeal)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchFilteredCategories (completion: @escaping (FilterCategories) -> (), category: String) {
        
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let category = try decoder.decode(FilterCategories.self, from: data)
                
                completion(category)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchSearchedID (completion: @escaping (SearchByID) -> (), id: String) {
        
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let mealID = try decoder.decode(SearchByID.self, from: data)
                
                completion(mealID)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }

}
