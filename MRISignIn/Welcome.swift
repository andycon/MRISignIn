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
    
    
    
    var body: some View {
        
        VStack{
            HStack {
                Text("DBIC")
                    .font(.custom("Quicksand-Regular", size: 50))
                    //.padding(.top, -5)
                Text("|")
                    .font(.custom("Qicksand-Regular", size: 75))
                    //.padding(.top, -5)
                    .foregroundColor(Color.red)
                VStack(alignment: .leading) {
                    Text("Dartmouth")
                    Text("Brain Imaging")
                    Text("Center")
                }
            }.padding(.top, -100)
          
            Text("Please remember to Sign In and Sign Out")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .padding(.top, 610.0)
                .background(
                    Image("scanner")
                )
          
        }
           
        
    }
    
}


struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
