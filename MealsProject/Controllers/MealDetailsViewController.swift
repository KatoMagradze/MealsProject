//
//  MealDetailsViewController.swift
//  MealsProject
//
//  Created by Kato on 7/12/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit
import SafariServices

class MealDetailsViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    
    let apiservice = APIService()
    
    @IBOutlet weak var blueView: UIView!
    
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealAreaLabel: UILabel!
    @IBOutlet weak var mealCategoryLabel: UILabel!
    //@IBOutlet weak var mealInstructionsLabel: UILabel!
    @IBOutlet weak var shadowBackground: UIView!
    @IBOutlet weak var youtubeButton: UIButton!
    
    var mealArr = [Meal]()
    
    var mealDetails: Filter?
    
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blueView.layer.cornerRadius = 15
        topView.layer.cornerRadius = 15
        
        //self.idFilter(idMeal: mealDetails?.idMeal ?? "52772")
        
        youtubeButton.layer.cornerRadius = 20
        
        shadowBackground.layer.cornerRadius = 15
        shadowBackground.layer.shadowColor = UIColor.black.cgColor
        shadowBackground.layer.shadowOpacity = 0.8
        shadowBackground.layer.shadowOffset = .zero
        shadowBackground.layer.shadowRadius = 10
        
        //shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
        shadowBackground.layer.shadowPath = UIBezierPath(roundedRect: shadowBackground.bounds, cornerRadius: shadowBackground.layer.cornerRadius).cgPath
        
        self.idFilter(idMeal: id)
        
    }
    
    func idFilter(idMeal: String) {
        
        apiservice.fetchSearchedID(completion: { (filteredIDs) in
            
            for ID in filteredIDs.meals {
                self.mealArr.append(ID)
            }
            
            DispatchQueue.main.async {
                self.mealNameLabel.text = self.mealArr[0].strMeal
                self.mealAreaLabel.text = "Area: \(self.mealArr[0].strArea ?? "")"
                self.mealCategoryLabel.text = "Category: \(self.mealArr[0].strCategory ?? "")"
                //self.youtubeURL = self.mealArr[0].strYoutube!
                //self.mealInstructionsLabel.text = self.mealArr[0].strInstructions
                
                self.mealImageView.layer.cornerRadius = 10
                
                self.mealArr[0].strMealThumb!.downloadImage { (image) in
                    DispatchQueue.main.async {
                        self.mealImageView.image = image
                    }
                }
            }
            
        }, id: idMeal)
    }
    
    
    @IBAction func youtubeTapped(_ sender: UIButton) {
        if mealArr[0].strYoutube != "" {
            let videoURL = URL(string: mealArr[0].strYoutube!)!
            let safariVC = SFSafariViewController(url: videoURL)
            present(safariVC, animated: true, completion: nil)
        }
    }
    
}
