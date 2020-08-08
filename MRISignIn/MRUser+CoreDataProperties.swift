//
//  MRUser+CoreDataProperties.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 8/6/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//
//

import Foundation
import CoreData


extension MRUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MRUser> {
        return NSFetchRequest<MRUser>(entityName: "MRUser")
    }

    @NSManaged public var firstName: String
    @NSManaged public var isLoggedIn: Bool
    @NSManaged public var lastLogin: String
    @NSManaged public var lastLogout: String
    @NSManaged public var lastName: String

}
