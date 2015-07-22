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
    var cityDataStoreInstance: CityDataStore?
    
    init() {
        nsUserDefaultsInstance = NSUserDefaultsService()
        cityDataStoreInstance = CityDataStore(nsUserDefaultsService: nsUserDefaultsInstance!)
    }
    
    class var sharedWorldClockControllerInstance: WorldClockController {
        struct WorldClockControllerSingleton {
            static let worldClockSingletonInstance = WorldClockController()
        }
        return WorldClockControllerSingleton.worldClockSingletonInstance
    }
    
    func setCityAsSelected(index: Int) {
        cityDataStoreInstance?.setCityAsSelected(index)
    }
    
    func setCityDeselected(index: Int) {
        cityDataStoreInstance?.setCityAsDeselected(index)
    }
    
   
}




