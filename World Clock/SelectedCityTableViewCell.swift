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
    var cityImageView: UIImageView?

    override func awakeFromNib() {
        cityImageView = UIImageView(frame: self.bounds)
        cityImageView?.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        var overlayImageView = UIImageView(image: UIImage(named: "image_over_dark"))
        overlayImageView.frame = self.bounds
        overlayImageView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        var subView1 = cityImageView
        var subView2 = overlayImageView
        var mainSubview = UIView(frame: self.bounds)
        mainSubview.addSubview(subView1!)
        mainSubview.addSubview(subView2)
        self.backgroundView = mainSubview
    }
}
