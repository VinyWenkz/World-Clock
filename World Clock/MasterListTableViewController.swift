//
//  MasterListTableViewController.swift
//  World Clock
//
//  Created by DGBendicion on 7/21/15.
//  Copyright (c) 2015 DGBendicion. All rights reserved.
//

import UIKit

class MasterListTableViewController: UITableViewController, CityCrudDelegate {
    let worldClockController = WorldClockController.sharedWorldClockControllerInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        worldClockController.cityDataStoreInstance?.addCityCrudDelegate(self)
    }
    
    deinit {
        worldClockController.cityDataStoreInstance?.removeCityCrudDelegate(self)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfCities = worldClockController.cityDataStoreInstance?.cities?.count {
            return numberOfCities
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cityCell", forIndexPath: indexPath) as! UITableViewCell
        if let city = worldClockController.cityDataStoreInstance?.cities?[indexPath.row] {
            
            cell.textLabel!.text = city.name
            cell.imageView?.image = UIImage(named: Utils.stripFilenameExtension(city.imageName))
            cell.detailTextLabel?.text = city.country
            
            if city.selected == true {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var city = worldClockController.cityDataStoreInstance?.cities![indexPath.row]
        if city?.selected == true {
            worldClockController.setCityDeselected(indexPath.row)
        } else {
            worldClockController.setCityAsSelected(indexPath.row)
        }
    }
    
    func listUpdated() {
        self.tableView.reloadData()
    }
}
