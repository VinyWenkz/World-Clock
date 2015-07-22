//
//  MasterViewController.swift
//  World Clock
//
//  Created by DGBendicion on 7/21/15.
//  Copyright (c) 2015 DGBendicion. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, CityCrudDelegate {

    var detailViewController: DetailViewController? = nil
    let worldClockController = WorldClockController.sharedWorldClockControllerInstance


    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        
        worldClockController.cityDataStoreInstance?.addCityCrudDelegate(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                
                if let selectedCity = worldClockController.cityDataStoreInstance?.selectedCities![indexPath.row] {
                    var urlRequest = NSURLRequest(URL: NSURL(string: selectedCity.link)!)
                    controller.cityUrlRequest = urlRequest
                }
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let selectedCitiesNum = worldClockController.cityDataStoreInstance?.selectedCities?.count {
            return selectedCitiesNum
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        if let selectedCities = worldClockController.cityDataStoreInstance?.selectedCities {
            let city = selectedCities[indexPath.row]
            cell.textLabel!.text = city.name
        }
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCellEditingStyle.None
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        if let selectedCities = worldClockController.cityDataStoreInstance?.selectedCities {
//            var itemToMove = selectedCities[sourceIndexPath.row]
//            selectedCities.removeAtIndex(sourceIndexPath.row)
//            selectedCities.insert(itemToMove, atIndex: destinationIndexPath.row)
            worldClockController.cityDataStoreInstance?.switchSelectedCityIndex(sourceIndexPath, toIndexPath: destinationIndexPath)
        }
    }

    @IBAction func editBarButtonItemPressed(sender: UIBarButtonItem) {
        self.editing = !self.editing
        
        if self.editing {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
        }
    }
    
    func listUpdated() {
        self.tableView.reloadData()
    }


}

