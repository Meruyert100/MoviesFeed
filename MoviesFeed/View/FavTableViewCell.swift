//
//  FavTableViewCell.swift
//  MoviesFeed
//
//  Created by Meruyert Tastandiyeva on 2/5/21.
//

import UIKit

class FavTableViewCell: UITableViewCell {

    @IBOutlet weak var favTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
