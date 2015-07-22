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
    var selectedCities: [City]?
    var selectedCityNamesArray: [String]?
    
    init(nsUserDefaultsService: NSUserDefaultsService) {
        super.init()
        self.nsUserDefaultsServiceInstance = nsUserDefaultsService
        self.cityCrudDelegates = [CityCrudDelegate]()
        self.cities = loadCitiesInPList()
        let cityTuple = loadSelectedCities()
        self.selectedCities = cityTuple.selectedCities
        self.selectedCityNamesArray = cityTuple.selectedCityNames
        
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
        self.selectedCities?.insert(self.cities![index], atIndex: findNextIndexInSelectedCityList())
        self.selectedCityNamesArray?.insert(self.cities![index].name, atIndex: findNextIndexInSelectedCityList()-1)
        nsUserDefaultsServiceInstance?.saveArray(self.selectedCityNamesArray!, key: Constants.CITY_PLIST_SELECTED_ARRAY)
        implementCityCrudDelegate()
    }
    
    func setCityAsDeselected(index: Int) {
        self.cities![index].selected = false
        self.selectedCities?.removeAtIndex(findIndexOfCity(self.cities![index].name))
        self.selectedCityNamesArray?.removeAtIndex(findIndexOfCity(self.cities![index].name))
        nsUserDefaultsServiceInstance?.removeArray(Constants.CITY_PLIST_SELECTED_ARRAY)
        nsUserDefaultsServiceInstance?.saveArray(self.selectedCityNamesArray!, key: Constants.CITY_PLIST_SELECTED_ARRAY)
        implementCityCrudDelegate()
    }
    
    func switchSelectedCityIndex(fromIndexPath: NSIndexPath , toIndexPath: NSIndexPath) {
        var cityToMove = self.selectedCities![fromIndexPath.row]
        self.selectedCities?.removeAtIndex(fromIndexPath.row)
        self.selectedCityNamesArray?.removeAtIndex(fromIndexPath.row)
        self.selectedCities?.insert(cityToMove, atIndex: toIndexPath.row)
        self.selectedCityNamesArray?.insert(cityToMove.name, atIndex: toIndexPath.row)
        nsUserDefaultsServiceInstance?.removeArray(Constants.CITY_PLIST_SELECTED_ARRAY)
        nsUserDefaultsServiceInstance?.saveArray(selectedCityNamesArray!, key: Constants.CITY_PLIST_SELECTED_ARRAY)
    }
    
    
    func implementCityCrudDelegate() {
        for cityCrudDelegate in cityCrudDelegates! {
            cityCrudDelegate.listUpdated?()
        }
    }

    
    func findIndexOfCity(cityName: String) -> Int {
        for var i = 0; i < self.selectedCities?.count; i++ {
            if cityName == self.selectedCities![i].name {
                return i
            }
        }
        return -1
    }

    
    func findNextIndexInSelectedCityList() -> Int {
        if let nextIndex = selectedCities?.count {
            return nextIndex
        }
        return 0
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
    
    func loadSelectedCities() -> (selectedCities: [City], selectedCityNames:[String]) {
        var cityList = [City]()
        var cityNameList = [String]()

        if let cityNames = nsUserDefaultsServiceInstance?.getArray(Constants.CITY_PLIST_SELECTED_ARRAY) {
            for cityName in cityNames {
                cityList.append(self.findCityFromList(cityName as! String)!)
            }
            cityNameList = cityNames as! [String]
        }

        return (cityList, cityNameList)
        
    }
    
    func findCityFromList(cityName: String) -> City? {
        for city in self.cities! {
            if city.name == cityName {
                return city
            }
        }
        return nil
    }
}
