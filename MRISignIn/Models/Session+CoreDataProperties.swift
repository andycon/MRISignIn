//
//  Session+CoreDataProperties.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 8/17/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session")
    }

    @NSManaged public var start: Date
    @NSManaged public var fin: Date
    @NSManaged public var users: String
    @NSManaged public var isCur: Bool
    @NSManaged public var n: Int
    @NSManaged public var id: UUID

}
