//
//  ScavengerHuntItem.swift
//  Scavenger Hunt
//
//  Created by Steven Mirabito on 1/26/16.
//  Copyright © 2016 StevTek. All rights reserved.
//

import UIKit

class ScavengerHuntItem: NSObject {
    
    let name: String
    var photo: UIImage?
    var completed: Bool {
        get {
            return photo != nil
        }
    }
    
    init(name: String){
        self.name = name
    }
    
}