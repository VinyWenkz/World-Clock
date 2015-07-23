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
        self.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: "editBarButtonItemPressed")
        removeEditBarButtonIfNeeded()
       
        
        
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
        } else if segue.identifier == "addRemoveCitySegue" {
            self.editing = false
            self.leftBarButtonItem.title = "Edit"
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
        let cell = tableView.dequeueReusableCellWithIdentifier("selectedCityCell", forIndexPath: indexPath) as! SelectedCityTableViewCell
        
        if let selectedCities = worldClockController.cityDataStoreInstance?.selectedCities {
            let city = selectedCities[indexPath.row]
            cell.cityImageView?.image = UIImage(named: Utils.stripFilenameExtension(city.imageName))
            cell.nameLabel.text = city.name
            cell.timeLabel.text = "12:00"
            cell.dateLabel.text = "12/01/12"
            cell.countryLabel.text = city.country
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        if let city = worldClockController.cityDataStoreInstance?.selectedCities?[indexPath.row] {
//
//            var cityImageView = UIImageView(image: UIImage(named: Utils.stripFilenameExtension(city.imageName)))
//            cityImageView.frame = cell.bounds
//            var overlayImageView = UIImageView(image: UIImage(named: "image_over_dark"))
//            overlayImageView.frame = cell.bounds
//            var subView1 = cityImageView
//         
//            var subView2 = overlayImageView
//
////            subView1.addSubview(subView2)
//            
//            var mainSubview = UIView(frame: cell.bounds)
//            mainSubview.addSubview(subView1)
//            mainSubview.addSubview(subView2)
//            
//            
//            
//            
//            cell.backgroundView = mainSubview
//            
//
//            
//            
////            cell.backgroundView = ((UIImageView(image: UIImage(named: Utils.stripFilenameExtension(city.imageName)))))
////            cell.backgroundColor = UIColor(patternImage: UIImage(named: "image_over_dark")!)
//            
//        }
        
        //cell.backgroundView = [[UIImageView, alloc] initWithImage:[ [UIImage imageNamed:@"cell_normal.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
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
            self.leftBarButtonItem.title = "Done"
        } else {
            self.leftBarButtonItem.title = "Edit"
        }
    }
    
    func removeEditBarButtonIfNeeded() {
        if worldClockController.cityDataStoreInstance?.selectedCities?.count < 2 {
            self.navigationItem.leftBarButtonItem = nil
        } else {
            self.navigationItem.leftBarButtonItem = self.leftBarButtonItem
        }
    }
    
    // MARK: - CountryCrudDelegate
    
    func listUpdated() {
        removeEditBarButtonIfNeeded()
        self.tableView.reloadData()
    }
    
   
    
    
}

