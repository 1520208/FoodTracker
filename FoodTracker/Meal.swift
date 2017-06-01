//
//  Meal.swift
//  FoodTracker
//
//  Created by Jacqueline Franßen on 31.05.17.
//  Copyright © 2017 Jacky's Code Factory. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding{
    
    //MARK:Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Types
    struct PropertyKey{
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        
    }
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int){
        //The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        //The rating must be between 0 and 5
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        //Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    //MARK: NsCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey:PropertyKey.name)
        aCoder.encode(photo, forKey:PropertyKey.photo)
        aCoder.encode(rating, forKey:PropertyKey.rating)

    }
    
    //required means that this initializer must be implemented on every subclass if the subclass defines its own initializers
    //? means that it is a failable initializer that might return nil
    required convenience init? (coder aDecoder: NSCoder) {
        //the name is required. if we cannot decode a name string, the initializer should fail
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
            else{
                os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
                return nil
            }
        //because photo is an optional property of meal, just use conditional cast
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        //must call designated initializer
        self.init(name: name, photo: photo, rating: rating)
    }
}
