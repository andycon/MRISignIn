//
//  SessionDetail.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 8/17/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//

import SwiftUI
import CoreData

struct SessionDetail: View {
    
    let contacts: [String]
    let sessDate: [String]
    
    let onComplete: (Bool) -> Void
    
    var body: some View {
        
        VStack {
            //List {
           
            Spacer()
            HStack {
                Spacer()
                VStack{
                    Text(sessDate[0])
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(sessDate[1])
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    Text("\(sessDate[2]) '\(sessDate[3])")
                        .font(.title)
                    }
                Spacer()
                Text(sessDate[4])
                    .font(.title)
                Spacer()
                Text("to")
                    .font(.title)
                Spacer()
                Text(sessDate[5])
                    .font(.title)
                Spacer()
               
            }
         
            Spacer()
            Text("Signed In:")
                .font(.title)
                .frame(width: 550, alignment: .leading)
                .foregroundColor(.gray)
            ForEach(self.contacts, id: \.self) { user in
                    
                Text(user)
                    .font(.largeTitle)
                    .frame(width: 400, alignment: .leading)
            
            }
                
            
            Spacer()
         
            Button(action: { self.dismiss() }) {
                Text("OK")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            Spacer()
           
                
        }
    }
    
    private func dismiss() {
        onComplete(false)
        
    }
 
}


