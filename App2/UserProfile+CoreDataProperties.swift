//
//  UserProfile+CoreDataProperties.swift
//  App2
//
//  Created by Franco Cirillo on 15/02/21.
//
//

import Foundation
import CoreData


extension UserProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserProfile> {
        return NSFetchRequest<UserProfile>(entityName: "UserProfile")
    }

    @NSManaged public var avatar: String?
    @NSManaged public var name: String?
    @NSManaged public var outLoud: Bool
    @NSManaged public var showPics: Bool

}

extension UserProfile : Identifiable {

}
