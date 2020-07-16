//
//  DetailsCell.swift
//  MealsProject
//
//  Created by Kato on 7/11/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {
    
    public static let identifier = "details_cell"

    @IBOutlet weak var foodNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
