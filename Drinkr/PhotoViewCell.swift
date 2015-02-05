//
//  PhotoViewCell.swift
//  Drinkr
//
//  Created by William Wettersten on 2/4/15.
//  Copyright (c) 2015 William Wettersten. All rights reserved.
//

import UIKit

class PhotoViewCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
