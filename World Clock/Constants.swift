//
//  Keys.swift
//  World Clock
//
//  Created by DGBendicion on 7/21/15.
//  Copyright (c) 2015 DGBendicion. All rights reserved.
//

import Foundation

class Constants {
    static let CITY_PLIST_FILENAME = "Cities"
    static let CITY_PLIST_TYPE = "plist"
    
    static let CITY_PLIST_TITLE_KEY = "cities"
    static let CITY_PLIST_NAME_KEY = "name"
    static let CITY_PLIST_COUNTRY_KEY = "country"
    static let CITY_PLIST_TIME_ZONE_KEY = "time_zone"
    static let CITY_PLIST_LINK_KEY = "link"
    static let CITY_PLIST_IMAGE_KEY = "image"
    
    static let CITY_PLIST_SELECTED_ARRAY = "selectedCities.array"
    
    static let DATE_FORMAT = "mm/dd/yy"
    static let TIME_FORMAT = "hh:mm aa"
    
    static let SEGUE_ADD_REMOVE_CITY = "addRemoveCitySegue"
    static let SEGUE_SHOW_DETAIL = "showDetail"
    
    static let CELL_ID_SELECTED_CITY = "selectedCityCell"
    static let CELL_ID_CITY = "cityCell"
    
}
