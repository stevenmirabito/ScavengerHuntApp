//
//  ListViewController.swift
//  Scavenger Hunt
//
//  Created by Steven Mirabito on 1/26/16.
//  Copyright © 2016 StevTek. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var itemsList = [
        ScavengerHuntItem(name: "Cat"),
        ScavengerHuntItem(name: "Bird"),
        ScavengerHuntItem(name: "Brick")
    ]
    
    @IBAction func unwindToList(segue: UIStoryboardSegue){
        // Stub, nothing here yet...
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath)
        
        let item = itemsList[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
    }
    
}