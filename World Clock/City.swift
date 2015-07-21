//
//  Skyline.swift
//  World Clock
//
//  Created by DGBendicion on 7/21/15.
//  Copyright (c) 2015 DGBendicion. All rights reserved.
//

import Foundation

class City: NSObject {
    var name: String
    var country: String
    var timeZone: String
    var link: String
    var imageName: String
    
    init(name: String, country: String, timeZone: String, link: String, imageName: String) {
        self.name = name
        self.country = country
        self.timeZone = timeZone
        self.link = link
        self.imageName = imageName
    }

}
