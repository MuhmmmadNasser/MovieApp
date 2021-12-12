//
//  SingleFavouriteTableViewCell.swift
//  MovieApp
//
//  Created by Mohamed on 16/08/2021.
//

import UIKit

class SingleFavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
