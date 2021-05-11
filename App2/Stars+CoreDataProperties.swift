//
//  Stars+CoreDataProperties.swift
//  App2
//
//  Created by Stefano D’Amato on 04/05/21.
//
//

import Foundation
import CoreData


extension Stars {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stars> {
        return NSFetchRequest<Stars>(entityName: "Stars")
    }

    @NSManaged public var level1: Int16
    @NSManaged public var level2: Int16
    @NSManaged public var level3: Int16
    @NSManaged public var level4: Int16
    @NSManaged public var level5: Int16
    @NSManaged public var level6: Int16
    @NSManaged public var level7: Int16
    @NSManaged public var level8: Int16
    @NSManaged public var level9: Int16
    @NSManaged public var level10: Int16
    @NSManaged public var level11: Int16
    @NSManaged public var level12: Int16
    @NSManaged public var level13: Int16
    @NSManaged public var level14: Int16
    @NSManaged public var level15: Int16
    @NSManaged public var level16: Int16
    @NSManaged public var level17: Int16
    @NSManaged public var level18: Int16
    @NSManaged public var level19: Int16
    @NSManaged public var level20: Int16
    @NSManaged public var level21: Int16
    @NSManaged public var level22: Int16
    @NSManaged public var level23: Int16
    @NSManaged public var level24: Int16
    @NSManaged public var level25: Int16
    @NSManaged public var level26: Int16
    @NSManaged public var level27: Int16
    @NSManaged public var level28: Int16
    @NSManaged public var level29: Int16
    @NSManaged public var level30: Int16
    @NSManaged public var level31: Int16
    @NSManaged public var level32: Int16
    @NSManaged public var level33: Int16
    @NSManaged public var level34: Int16
    @NSManaged public var level35: Int16
    @NSManaged public var level36: Int16
    @NSManaged public var level37: Int16
    @NSManaged public var level38: Int16
    @NSManaged public var level39: Int16
    @NSManaged public var level40: Int16
    
    @NSManaged public var user: UserProfile?

}

extension Stars : Identifiable {

}
