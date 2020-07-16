//
//  FavoritesCell.swift
//  MealsProject
//
//  Created by Kato on 7/12/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

protocol DownloadProtocol {
    func didTapDownload(mealID: String)
}

class FavoritesCell: UITableViewCell {

    public static let identifier = "favorites_cell"
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    var delegate: DownloadProtocol?
    var id = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func downloadTapped(_ sender: UIButton) {
        delegate?.didTapDownload(mealID: id)
    }
}
