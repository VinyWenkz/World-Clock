//
//  WorldClockController.swift
//  World Clock
//
//  Created by DGBendicion on 7/21/15.
//  Copyright (c) 2015 DGBendicion. All rights reserved.
//

import Foundation

class  WorldClockController {
    
    var nsUserDefaultsInstance: NSUserDefaultsService?
    var cities: [City]?
    
    init() {
        nsUserDefaultsInstance = NSUserDefaultsService()
        cities = loadCitiesInPList()
    }
    
    class var sharedWorldClockControllerInstance: WorldClockController {
        struct WorldClockControllerSingleton {
            static let worldClockSingletonInstance = WorldClockController()
        }
        return WorldClockControllerSingleton.worldClockSingletonInstance
    }
    
    private func loadCitiesInPList() -> [City] {
        var citiesDictionaryArray: [NSDictionary]?
        var cityList = [City]()
        if let path = NSBundle.mainBundle().pathForResource(Constants.CITY_PLIST_FILENAME,
            ofType: Constants.CITY_PLIST_TYPE) {
                var citiesDictionary =  NSDictionary(contentsOfFile: path)!
                citiesDictionaryArray = citiesDictionary.objectForKey(Constants.CITY_PLIST_TITLE_KEY)
                    as? [NSDictionary]
                
                for cityDictionary: NSDictionary in citiesDictionaryArray! {
                    cityList.append(City(name: cityDictionary.objectForKey(Constants.CITY_PLIST_NAME_KEY) as! String,
                        country: cityDictionary.objectForKey(Constants.CITY_PLIST_COUNTRY_KEY) as! String,
                        timeZone: NSTimeZone(forSecondsFromGMT: cityDictionary.objectForKey(Constants.CITY_PLIST_TIME_ZONE_KEY) as! Int),
                        link: cityDictionary.objectForKey(Constants.CITY_PLIST_LINK_KEY) as! String,
                        imageName: cityDictionary.objectForKey(Constants.CITY_PLIST_IMAGE_KEY) as! String,
                        selected: nsUserDefaultsInstance!.isCitySelected(cityDictionary.objectForKey(Constants.CITY_PLIST_NAME_KEY) as! String)))
                }
                return cityList
    
        } else {
            return cityList
        }
    }
}




