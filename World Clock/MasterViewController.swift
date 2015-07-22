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
    var objects = [AnyObject]()
    var selectedCities = [City]()
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
        getSelectedCities()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                var urlRequest = NSURLRequest(URL: NSURL(string: selectedCities[indexPath.row].link)!)
                controller.cityUrlRequest = urlRequest
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
        return selectedCities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        let city = selectedCities[indexPath.row]
        cell.textLabel!.text = city.name
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
        var itemToMove = selectedCities[sourceIndexPath.row]
        selectedCities.removeAtIndex(sourceIndexPath.row)
        selectedCities.insert(itemToMove, atIndex: destinationIndexPath.row)
    }

    @IBAction func editBarButtonItemPressed(sender: UIBarButtonItem) {
        self.editing = !self.editing
        
        if self.editing {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
        }
    }

    func getSelectedCities() {
        selectedCities.removeAll(keepCapacity: false)
        if let cities = worldClockController.cityDataStoreInstance?.cities {
            for city in cities {
                if city.selected == true {
                    selectedCities.append(city)
                }
            }
        }
    }
    
    func listUpdated() {
        getSelectedCities()
        self.tableView.reloadData()
    }


}

