//
//  Structs.swift
//  MealsProject
//
//  Created by Kato on 7/7/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import Foundation

// MARK: - RandomMeal

struct RandomMeal: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let idMeal, strMeal, strCategory, strArea, strInstructions: String?
    var strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1 : String?
    let strIngredient2 : String?
    let strIngredient3 : String?
    let strIngredient4 : String?
    let strIngredient5 : String?
    let strIngredient6 : String?
    let strIngredient7 : String?
    let strIngredient8 : String?
    let strIngredient9 : String?
    let strIngredient10 : String?
    let strIngredient11 : String?
    let strIngredient12 : String?
    let strIngredient13 : String?
    let strIngredient14 : String?
    let strIngredient15 : String?
    let strIngredient16 : String?
    let strIngredient17 : String?
    let strIngredient18 : String?
    let strIngredient19 : String?
    let strIngredient20 : String?
}

// MARK: - AllCategories
struct AllCategories: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let idCategory, strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}

// MARK: - AllAreas
struct AllAreas: Codable {
    let meals: [Area]
}

struct Area: Codable {
    let strArea: String
}

struct FilteredAreas: Codable {
    let meals: [Filter]
}

// MARK: - Meal
struct Filter: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

// MARK: - FilterCategories
struct FilterCategories: Codable {
    let meals: [Filter]
}

struct SearchResults: Codable {
    let meals: [Meal]
}

struct SearchByID: Codable {
    let meals: [Meal]
}
