//
//  FilteredAreasCell.swift
//  MealsProject
//
//  Created by Kato on 7/9/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

protocol DetailsProtocol {
    //func didTapDetails(mealID: String, buttonIndex: Int)
    func didTapDetails(mealID: String)
    func didTapAddToFavs(mealID: String)
}

class FilteredAreasCell: UITableViewCell {
    
    public static let identifier = "filtered_areas_cell"

    @IBOutlet weak var filteredAreaImageView: UIImageView!
    @IBOutlet weak var filteredAreaLabel: UILabel!
//    @IBOutlet weak var detailsButton: CustomDetailButton!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var addToFavsLabel: UIButton!
    
    @IBOutlet weak var shadowView: UIView!
    
    var id = ""
    
    var idOfTheMeal: Meal?
    
    var delegate: DetailsProtocol?
    
    //var buttonIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        shadowView.layer.cornerRadius = 90/2
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 10
        
        //shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: shadowView.layer.cornerRadius).cgPath
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    @IBAction func detailsButtonTapped(_ sender: UIButton) {
//        delegate?.didTapDetails(mealID: idOfTheMeal?.idMeal ?? "52772")
        delegate?.didTapDetails(mealID: id)
    }
    //    @IBAction func detailsTapped(_ sender: CustomDetailButton) {
//        delegate?.didTapDetails(mealID: id, buttonIndex: sender.buttonCellIndex!)
//    }
    
    @IBAction func addToFavsTapped(_ sender: UIButton) {
        delegate?.didTapAddToFavs(mealID: id)
    }
    
}

class CustomDetailButton: UIButton {
    
    var buttonCellIndex : Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setUpButton()
    }
    
    func setUpButton() {
        self.buttonCellIndex = 0
    }
    
    func setDetailedButtonIndex(buttonIndex: Int) {
        self.buttonCellIndex = buttonIndex
    }
}
