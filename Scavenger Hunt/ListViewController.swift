//
//  ListViewController.swift
//  Scavenger Hunt
//
//  Created by Steven Mirabito on 1/26/16.
//  Copyright © 2016 StevTek. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let myManager = ItemsManager()
    
    @IBAction func clearList(sender: AnyObject) {
        let clearConfirmController = UIAlertController(title: "Are you sure you want to clear the list?", message: "This action cannot be undone.", preferredStyle: .ActionSheet)
        let clearYesAction = UIAlertAction(title: "Remove All Items", style: .Destructive) { (action) in
            self.myManager.itemsList = [ScavengerHuntItem]();
            self.myManager.save()
            
            var indexPathsToDelete = [NSIndexPath]()
            if self.tableView.numberOfRowsInSection(0) > 0 {
                for i in 0...self.tableView.numberOfRowsInSection(0) - 1 {
                    indexPathsToDelete.append(NSIndexPath(forRow: i, inSection: 0))
                }
                
                self.tableView.deleteRowsAtIndexPaths(indexPathsToDelete, withRowAnimation: .Automatic)
            }
        }
        
        let clearCancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        
        clearConfirmController.addAction(clearYesAction)
        clearConfirmController.addAction(clearCancelAction)
        
        self.presentViewController(clearConfirmController, animated: true, completion: nil)
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue){
        if segue.identifier == "DoneItem" {
            let addVC = segue.sourceViewController as! AddItemViewController
            if let newItem = addVC.newItem {
                myManager.itemsList += [newItem]
                myManager.save()
                let indexPath = NSIndexPath(forRow: myManager.itemsList.count - 1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myManager.itemsList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath)
        
        let item = myManager.itemsList[indexPath.row]
        cell.textLabel?.text = item.name
        
        if(item.completed) {
            cell.accessoryType = .Checkmark
            
            if (item.requireImage) {
                cell.imageView?.image = item.photo
            }
        } else {
            cell.accessoryType = .None
            cell.imageView?.image = nil
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedItem = myManager.itemsList[indexPath.row]
        
        if (selectedItem.requireImage) {
            let imagePicker = UIImagePickerController()
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            } else {
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            }
            
            imagePicker.delegate = self
            presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            selectedItem.completed = true
            myManager.save()
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            myManager.itemsList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            myManager.save()
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedItem = myManager.itemsList[indexPath.row]
            let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
            selectedItem.photo = photo
            myManager.save()
        
            dismissViewControllerAnimated(true, completion: {
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
        }
    }

}