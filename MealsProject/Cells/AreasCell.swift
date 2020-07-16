//
//  AreasCell.swift
//  MealsProject
//
//  Created by Kato on 7/9/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class AreasCell: UICollectionViewCell {
    
    public static let identifier = "areas_cell"
    
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var areaBackgroundView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.layer.cornerRadius = 92/2
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 2
        
        //shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: shadowView.layer.cornerRadius).cgPath
        
        
    }
}
