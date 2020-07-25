//
//  MRUser.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 7/23/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//

import Foundation
import SwiftUI
import CoreLocation

struct MRUser: Hashable, Codable, Identifiable {
    var id: Int
    var firstName: String
    var lastName: String
    fileprivate var imageName: String
    var isLoggedIn: Bool
    var lastLogin: String
    var lastLogout: String

}

extension MRUser {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}
