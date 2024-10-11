//
//  UserInfo+CoreDataProperties.swift
//  Fitness Ferrymen
//
//  Created by Miles Belknap on 5/1/21.
//  Copyright © 2021 Miles Belknap. All rights reserved.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var userHeight: Double
    @NSManaged public var userWeight: Double
    @NSManaged public var userAge: Double
    @NSManaged public var littleExercise: Bool
    @NSManaged public var lightExercise: Bool
    @NSManaged public var moderateExercise: Bool
    @NSManaged public var heavyExercise: Bool
    @NSManaged public var exerciseLevel: Double
    @NSManaged public var isMuscleGaining: Bool
    @NSManaged public var isMaintaining: Bool
    @NSManaged public var isLosingWeight: Bool
    @NSManaged public var isMale: Bool
    @NSManaged public var isFemale: Bool
    @NSManaged public var brm: Double
    @NSManaged public var tdee: Double
    @NSManaged public var totalCaloriesRequired: Double
    @NSManaged public var proteinGramsRequired: Double
    @NSManaged public var proteinCalsRequired: Double
    @NSManaged public var carbsCalsRequired: Double
    @NSManaged public var carbsGramsRequired: Double
    @NSManaged public var fatGramsRequired: Double
    @NSManaged public var fatCalsRequired: Double
    @NSManaged public var totalCalRequired: Int
    @NSManaged public var caloriesTaken: String
    @NSManaged public var name: String
    @NSManaged public var takenCalories: Double
    @NSManaged public var title: String
    @NSManaged public var caloriesPlanned: String


    
    

}
