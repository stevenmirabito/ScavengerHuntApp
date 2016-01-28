//
//  AddTableViewController.swift
//  Scavenger Hunt
//
//  Created by Steven Mirabito on 1/27/16.
//  Copyright © 2016 StevTek. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    // Variables to hold saved values once the UI is destroyed
    var newItem: ScavengerHuntItem?
    var requireImage: Bool?
    
    // UI element outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var requireImageSwitch: UISwitch!
    
    @IBAction func cancelToListView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0) {
            textField.becomeFirstResponder()
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "DoneItem" {
            if let name = textField.text {
                if name.isEmpty {
                    let emptyAlertController = UIAlertController(title: "Invalid Item Name", message: "The item name cannot be blank.", preferredStyle: .Alert)
                    let emptyOkAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    
                    emptyAlertController.addAction(emptyOkAction)
                    self.presentViewController(emptyAlertController, animated: true, completion: nil)
                    
                    return false
                } else {
                    return true
                }
            }
        }
        
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DoneItem" {
            if let name = textField.text {
                if !name.isEmpty {
                    newItem = ScavengerHuntItem(name: name, requireImage: requireImageSwitch.on)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
    }
    
}

