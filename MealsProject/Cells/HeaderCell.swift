//
//  HeaderCell.swift
//  MealsProject
//
//  Created by Kato on 7/7/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    public static let identifier = "header_cell"
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var randomMealImageView: UIImageView!
    @IBOutlet weak var randomMealNameLabel: UILabel!
    @IBOutlet weak var shadowBackground: UIView!
    
    @IBOutlet weak var gradientView: GradientView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        shadowBackground.layer.cornerRadius = 20
        shadowBackground.layer.shadowColor = UIColor.black.cgColor
        shadowBackground.layer.shadowOpacity = 0.8
        shadowBackground.layer.shadowOffset = .zero
        shadowBackground.layer.shadowRadius = 10
        
        //shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
        shadowBackground.layer.shadowPath = UIBezierPath(roundedRect: shadowBackground.bounds, cornerRadius: shadowBackground.layer.cornerRadius).cgPath
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
