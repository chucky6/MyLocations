//
//  Location+CoreDataProperties.swift
//  MyLocations
//
//  Created by Antonio Alves on 1/31/16.
//  Copyright © 2016 Antonio Alves. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData
import CoreLocation

extension Location {

    @NSManaged var category: String
    @NSManaged var date: NSDate
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var locationDescription: String
    @NSManaged var placemark: CLPlacemark?

}
