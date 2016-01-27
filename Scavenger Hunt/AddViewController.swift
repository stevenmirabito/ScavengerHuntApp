//
//  ViewController.swift
//  Scavenger Hunt
//
//  Created by Steven Mirabito on 1/26/16.
//  Copyright © 2016 StevTek. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    var newItem: ScavengerHuntItem?

    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "DoneItem" {
            if let name = textField.text {
                if name.isEmpty {
                    let emptyAlertController = UIAlertController(title: "Invalid Item Name", message: "The item name cannot be blank", preferredStyle: .Alert)
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
                    newItem = ScavengerHuntItem(name: name)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

