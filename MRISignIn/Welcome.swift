//
//  Welcome.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 8/7/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//

import SwiftUI
import Foundation

struct Welcome: View {
    
    var message: String
    
    var body: some View {
        
        Text("\(message) \nPlease Sign In")
            .font(.headline)
            .fontWeight(.heavy)
            .background(
                Image("scanner")

            )
        
    }
}

