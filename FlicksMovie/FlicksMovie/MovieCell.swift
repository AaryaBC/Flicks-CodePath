//
//  MovieCell.swift
//  FlicksMovie
//
//  Created by Aarya BC on 1/29/17.
//  Copyright © 2017 Aarya BC. All rights reserved.
//

import UIKit
import HCSStarRatingView

class MovieCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var voteCount: HCSStarRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
