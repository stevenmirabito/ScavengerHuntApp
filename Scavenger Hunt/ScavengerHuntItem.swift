//
//  ScavengerHuntItem.swift
//  Scavenger Hunt
//
//  Created by Steven Mirabito on 1/26/16.
//  Copyright © 2016 StevTek. All rights reserved.
//

import UIKit

class ScavengerHuntItem: NSObject, NSCoding {
    
    let name: String
    var photo: UIImage?
    var completed: Bool {
        get {
            return photo != nil
        }
    }
    
    let nameKey = "name"
    let photoKey = "photo"
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: nameKey)
        if let thePhoto = photo {
            aCoder.encodeObject(thePhoto, forKey: photoKey)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(nameKey) as! String
        photo = aDecoder.decodeObjectForKey(photoKey) as? UIImage
    }
    
    init(name: String){
        self.name = name
    }
    
}