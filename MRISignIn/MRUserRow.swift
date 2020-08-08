//
//  ContentView.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 7/23/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//

import SwiftUI
import Foundation
import CoreData

func getTime() -> String {
    
    let time = Date()
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .short
    let dateTimeString = formatter.string(from: time)
    
    return dateTimeString
}

struct MRUserRow: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var mruser: MRUser
    var linkToDetail: Bool = true

  
    var body: some View {
       
        
        //let dest = { UserDetailView(mruser: self.mruser)
         //   .environment(\.managedObjectContext, self.managedObjectContext) as! Bool ?? linkToDetail : {} }
        
        NavigationLink(destination:
            UserDetailView(mruser: self.mruser)
                .environment(\.managedObjectContext, self.managedObjectContext)
            )
        {
           HStack {
                    VStack(alignment: .leading) {
                        Text(mruser.firstName)
                        Text(mruser.lastName)
                    }
                
                    Spacer()
            
                    if self.mruser.isLoggedIn {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Color.green)
                        }
                    else {
                        Image(systemName: "circle")
                            .foregroundColor(Color.black)
                        }
           
                }
        }
    
        
        
       
    }
}
        
    
   
    
    
    
  
