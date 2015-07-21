//
//  NSUserDefaultsService.swift
//  World Clock
//
//  Created by DGBendicion on 7/21/15.
//  Copyright (c) 2015 DGBendicion. All rights reserved.
//

import Foundation

class NSUserDefaultsService: NSObject {
    var nsUserDefaultsInstance: NSUserDefaults?
    
    override init() {
        self.nsUserDefaultsInstance = NSUserDefaults.standardUserDefaults()
    }
    
    func saveString(stringValue: String, key: String) {
        nsUserDefaultsInstance?.setValue(stringValue, forKey: key)
    }
    
    func removeString(key: String) {
        nsUserDefaultsInstance?.removeObjectForKey(key)
    }
    
    func setCitySelected(cityName: String, cityCrudDelegateList: [CityCrudDelegate]) {
        saveString(cityName, key: cityName)
        for  cityCrudDelegate in cityCrudDelegateList {
            cityCrudDelegate.cityAdded?()
        }
    }
    
    func setCityDeselected(cityName: String, cityCrudDelegateList: [CityCrudDelegate]) {
        removeString(cityName)
        for cityCrudDelegate in cityCrudDelegateList {
            cityCrudDelegate.cityRemoved?()
        }
    }

    func isCitySelected(cityName: String) -> Bool {
        if let city = nsUserDefaultsInstance?.valueForKey(cityName) as? String {
            return true
        }
        return false
    }
    
    
    
}
