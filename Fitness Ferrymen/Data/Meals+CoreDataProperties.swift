//
//  Meals+CoreDataProperties.swift
//  Fitness Ferrymen
//
//  Created by Miles Belknap on 5/20/21.
//  Copyright © 2021 Miles Belknap. All rights reserved.
//
//

import Foundation
import CoreData


extension Meals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meals> {
        return NSFetchRequest<Meals>(entityName: "Meals")
    }

    @NSManaged public var name: String?
    @NSManaged public var caloriesTaken: String?

}
