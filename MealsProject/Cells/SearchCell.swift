//
//  SearchCell.swift
//  MealsProject
//
//  Created by Kato on 7/9/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    public static let identifier = "search_cell"
    
    @IBOutlet weak var searchedMealImageView: UIImageView!
    @IBOutlet weak var searchedMealName: UILabel!
    @IBOutlet weak var searchedMealCategory: UILabel!
    @IBOutlet weak var searchedMealArea: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
