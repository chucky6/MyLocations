//
//  CategoryPickerTableViewController.swift
//  MyLocations
//
//  Created by Antonio Alves on 1/31/16.
//  Copyright © 2016 Antonio Alves. All rights reserved.
//

import UIKit

class CategoryPickerTableViewController: UITableViewController {
    
    var selectedCategoryName = ""
    let categories = [
        "No Category",
        "Apple Store",
        "Bar",
        "Bookstore",
        "Club",
        "Grocery Store",
        "Historic Building",
        "House",
        "Icecream Vendor",
        "Landmark",
        "Park"]
    var selectedIndexPath = NSIndexPath()
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0..<categories.count {
            if categories[i] == selectedCategoryName {
                selectedIndexPath = NSIndexPath(forRow: i, inSection: 0)
                break
            }
        }
        tableView.backgroundColor = UIColor.blackColor()
        tableView.separatorColor = UIColor(white: 1.0, alpha: 0.2)
        tableView.indicatorStyle = .White
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let categoryName = categories[indexPath.row]
        cell.textLabel?.text = categoryName
        
        if categoryName == selectedCategoryName {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row != selectedIndexPath.row {
            if let newCell = tableView.cellForRowAtIndexPath(indexPath) {
                newCell.accessoryType = .Checkmark
            }
            if let oldCell = tableView.cellForRowAtIndexPath(selectedIndexPath) {
                oldCell.accessoryType = .None
            }
            selectedIndexPath = indexPath
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PickedCategory" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPathForCell(cell) {
                selectedCategoryName = categories[indexPath.row]
            }
        }
    }
    
    override func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
            cell.backgroundColor = UIColor.blackColor()
            if let textLabel = cell.textLabel {
                textLabel.textColor = UIColor.whiteColor()
                textLabel.highlightedTextColor = textLabel.textColor
            }
            let selectionView = UIView(frame: CGRect.zero)
            selectionView.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
            cell.selectedBackgroundView = selectionView
    }
}
