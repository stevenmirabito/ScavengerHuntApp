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
    let requireImage: Bool
    var photo: UIImage?
    private var _completed: Bool
    
    var completed: Bool {
        get {
            if (self.requireImage) {
                return photo != nil
            } else {
                return self._completed
            }
        }
        set (value) {
            if (self.requireImage) {
                assertionFailure("Cannot set completed on a ScavengerHuntItem that requires an image")
            } else {
                self._completed = value
            }
        }
    }
    
    private let nameKey = "name"
    private let photoKey = "photo"
    private let requireImageKey = "requireImage"
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: nameKey)
        aCoder.encodeObject(requireImage, forKey: requireImageKey)
        if let thePhoto = photo {
            aCoder.encodeObject(thePhoto, forKey: photoKey)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(nameKey) as! String
        requireImage = aDecoder.decodeObjectForKey(requireImageKey) as! Bool
        photo = aDecoder.decodeObjectForKey(photoKey) as? UIImage
        self._completed = false
    }
    
    init(name: String, requireImage: Bool){
        self.name = name
        self.requireImage = requireImage
        self._completed = false
    }
    
}