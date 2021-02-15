//
//  UserProfile+CoreDataProperties.swift
//  App2
//
//  Created by Marco Venere on 15/02/21.
//
//

import Foundation
import CoreData


extension UserProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserProfile> {
        return NSFetchRequest<UserProfile>(entityName: "UserProfile")
    }

    @NSManaged public var name: String?
    @NSManaged public var outLoud: Bool
    @NSManaged public var showPics: Bool
    @NSManaged public var avatar: String?

}

extension UserProfile : Identifiable {

}
