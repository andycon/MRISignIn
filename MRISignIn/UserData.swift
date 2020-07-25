//
//  UserData.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 7/24/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var mrusers = mruserData
}
