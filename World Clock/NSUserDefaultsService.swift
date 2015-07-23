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
    
    func saveInt(intValue: Int, key: String) {
        nsUserDefaultsInstance?.setInteger(intValue, forKey: key)
    }
    
    func removeInt(key: String) {
        nsUserDefaultsInstance?.removeObjectForKey(key)
    }
    
    func getInt(key: String) -> Int {
        if let intValue = nsUserDefaultsInstance?.integerForKey(key) {
            return intValue
        }
        return -1
    }
    
    func saveArray(arrayValue: [AnyObject], key: String) {
        nsUserDefaultsInstance?.setValue(arrayValue, forKey: key)
    }
    
    func removeArray(key: String) {
        nsUserDefaultsInstance?.removeObjectForKey(key)
    }
    
    func saveDictionary(dictionaryValue: NSDictionary, key: String) {
        nsUserDefaultsInstance?.setObject(dictionaryValue, forKey: key)
    }
    
    func removeDictionary(key: String) {
        nsUserDefaultsInstance?.removeObjectForKey(key)
    }
    
    func getDictionary(key: String) -> NSDictionary {
        return nsUserDefaultsInstance?.objectForKey(key) as! NSDictionary
    }
    
    func getArray(key: String) -> [AnyObject] {
        if let arrayValue = nsUserDefaultsInstance?.objectForKey(key) as? [AnyObject] {
            return arrayValue
        } else {
            return [AnyObject]()
        }
    }

    func isCitySelected(cityNameString: String) -> Bool {
        var citiesNameInArray = getArray(Constants.CITY_PLIST_SELECTED_ARRAY) as! [String]
        
        for cityNameInArray in citiesNameInArray {
            if cityNameString == cityNameInArray {
                return true
            }
        }
        return false
    }
    
    
    
}
