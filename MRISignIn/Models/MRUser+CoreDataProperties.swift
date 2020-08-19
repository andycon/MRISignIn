//
//  MRUser+CoreDataProperties.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 8/17/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//
//

import Foundation
import CoreData


extension MRUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MRUser> {
        return NSFetchRequest<MRUser>(entityName: "MRUser")
    }

    @NSManaged public var createdOn: Date
    @NSManaged public var firstName: String
    @NSManaged public var id: UUID
    @NSManaged public var isLoggedIn: Bool
    @NSManaged public var lastLogin: Date
    @NSManaged public var lastLogout: Date
    @NSManaged public var lastName: String
    @NSManaged public var nSessions: Int
    @NSManaged public var sessionContacts: String
    @NSManaged public var sessions: String
    @NSManaged public var sessionTime: Date

}
