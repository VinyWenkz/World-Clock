//
//  SelectedCityTableViewCell.swift
//  World Clock
//
//  Created by DGBendicion on 7/23/15.
//  Copyright (c) 2015 DGBendicion. All rights reserved.
//

import UIKit

class SelectedCityTableViewCell: UITableViewCell {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedCityImage: UIImage?
    var overlayBgImageView: UIImageView?
    
    override func awakeFromNib() {
    }
}
