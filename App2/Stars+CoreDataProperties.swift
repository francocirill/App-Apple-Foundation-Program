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
    @NSManaged public var user: UserProfile?

}

extension Stars : Identifiable {

}
