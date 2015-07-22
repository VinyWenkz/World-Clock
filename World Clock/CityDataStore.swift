//
//  CityDataStore.swift
//  World Clock
//
//  Created by DGBendicion on 7/21/15.
//  Copyright (c) 2015 DGBendicion. All rights reserved.
//

import Foundation

class CityDataStore: NSObject {
    var cities: [City]?
    var nsUserDefaultsServiceInstance: NSUserDefaultsService?
    var cityCrudDelegates: [CityCrudDelegate]?
    
    init(nsUserDefaultsService: NSUserDefaultsService) {
        super.init()
        self.nsUserDefaultsServiceInstance = nsUserDefaultsService
        self.cityCrudDelegates = [CityCrudDelegate]()
        self.cities = loadCitiesInPList()
    }
    
    func addCityCrudDelegate(cityCrudDelegate: CityCrudDelegate) {
        self.cityCrudDelegates?.append(cityCrudDelegate)
    }
    
    func removeCityCrudDelegate(cityCrudDelegate: CityCrudDelegate) {
        var index: Int = -1
        if cityCrudDelegates?.count > 0 {
            for var i = 0; i < cityCrudDelegates?.count; i++ {
                if cityCrudDelegates![i] === cityCrudDelegate {
                    index = i
                }
            }
            cityCrudDelegates?.removeAtIndex(index)
        }
    }
    
    func getCitiesCount() -> Int {
        return self.cities!.count
    }
    
    func setCityAsSelected(index: Int) {
        self.cities![index].selected = true
        nsUserDefaultsServiceInstance?.saveString(self.cities![index].name,
            key: Constants.CITY_PLIST_NAME_KEY)
        for cityCrudDelegate in cityCrudDelegates! {
            cityCrudDelegate.listUpdated?()
        }
    }
    
    func setcityAsDeselected(index: Int) {
        nsUserDefaultsServiceInstance?.removeString(self.cities![index].name)
        self.cities![index].selected = false
        for cityCrudDelegate in cityCrudDelegates! {
            cityCrudDelegate.listUpdated?()
        }
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
                        selected: nsUserDefaultsServiceInstance!.isCitySelected(cityDictionary.objectForKey(Constants.CITY_PLIST_NAME_KEY) as! String)))
                }
                return cityList
                
        } else {
            return cityList
        }
    }
}
