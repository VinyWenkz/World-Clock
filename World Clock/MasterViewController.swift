//
//  MasterViewController.swift
//  World Clock
//
//  Created by DGBendicion on 7/21/15.
//  Copyright (c) 2015 DGBendicion. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, CityCrudDelegate, TimerUpdateDelegate {
    
    var detailViewController: DetailViewController? = nil
    let worldClockController = WorldClockController.sharedWorldClockControllerInstance
    
    @IBOutlet weak var addBarButton: UIButton!
    var leftBarButtonItem: UIBarButtonItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        
        worldClockController.cityDataStoreInstance?.addCityCrudDelegate(self)
        worldClockController.timerService?.addTimerUpdateDelegate(self)

        self.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("EDIT", comment: "Edit"), style: UIBarButtonItemStyle.Plain, target: self, action: "editBarButtonItemPressed")
        removeEditBarButtonIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        worldClockController.cityDataStoreInstance?.removeCityCrudDelegate(self)
        worldClockController.timerService?.removeTimerUpdateDelegate(self)
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constants.SEGUE_SHOW_DETAIL {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                
                if let selectedCity = worldClockController.cityDataStoreInstance?.selectedCities![indexPath.row] {
                    var urlRequest = NSURLRequest(URL: NSURL(string: selectedCity.link)!)
                    controller.cityUrlRequest = urlRequest
                }
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == Constants.SEGUE_ADD_REMOVE_CITY {
            self.editing = false
            self.leftBarButtonItem.title = NSLocalizedString("EDIT", comment: "Edit")
        }
    }
    @IBAction func addBarButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier(Constants.SEGUE_ADD_REMOVE_CITY, sender: self)
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
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CELL_ID_SELECTED_CITY, forIndexPath: indexPath) as! SelectedCityTableViewCell
        
        if let selectedCities = worldClockController.cityDataStoreInstance?.selectedCities {
            let city = selectedCities[indexPath.row]
            
            var timeAndDate = Utils.getFormattedCurrentDateAndTime(forTimeZone: city.timeZone,
                withDateFormat: Constants.DATE_FORMAT, andTimeFormat: Constants.TIME_FORMAT)
            
            cell.cityImageView?.image = UIImage(named: Utils.stripFilenameExtension(city.imageName))
            cell.nameLabel.text = city.name
            cell.timeLabel.text = timeAndDate.formattedCurrentTime
            cell.dateLabel.text = timeAndDate.formattedCurrentDate
            cell.countryLabel.text = city.country
        }
        
        hideDateAndTimeIfNeeded(cell)

        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
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
            worldClockController.cityDataStoreInstance?.switchSelectedCityIndex(sourceIndexPath, toIndexPath: destinationIndexPath)
        }
    }
    
    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    // MARK: - Own
    
    func editBarButtonItemPressed() {
        self.editing = !self.editing
        
        if self.editing {
            self.leftBarButtonItem.title = NSLocalizedString("DONE", comment: "Done")
        } else {
            self.leftBarButtonItem.title = NSLocalizedString("EDIT", comment: "Edit")
        }
        
        self.tableView.reloadData()
    }
    
    func removeEditBarButtonIfNeeded() {
        if worldClockController.cityDataStoreInstance?.selectedCities?.count < 2 {
            self.navigationItem.leftBarButtonItem = nil
        } else {
            self.navigationItem.leftBarButtonItem = self.leftBarButtonItem
        }
    }
    
    func hideDateAndTimeIfNeeded(cell: SelectedCityTableViewCell) {
        if self.editing {
            cell.timeLabel.hidden = true
            cell.dateLabel.hidden = true
        } else {
            cell.timeLabel.hidden = false
            cell.dateLabel.hidden = false
        }
    }
    
    // MARK: - CountryCrudDelegate
    
    func listUpdated() {
        removeEditBarButtonIfNeeded()
        self.tableView.reloadData()
    }
    
    // MARK: - TimerUpdateDelegate
    
    func changeDate() {
        self.tableView.reloadData()
    }
    
    func changeTime() {
        self.tableView.reloadData()
    }
    
    
    
    
}

