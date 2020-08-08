//
//  UserDetailView.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 8/7/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//

import SwiftUI
import CoreData

struct UserDetailView: View {
    
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var mruser: MRUser
    var loggedinMessage: String = "Is Currently Logged In?"
    
  
    var body: some View {
        
    
        
        VStack{
            Text(mruser.firstName)
            Text(mruser.lastName)
            Text(loggedinMessage)
            Text(String(mruser.isLoggedIn))
            
         
            Button(action: {
  
                self.mruser.isLoggedIn.toggle()
                self.saveContext()

            })
            {
            
            if mruser.isLoggedIn {
                Image(systemName: "circle.fill")
                    .foregroundColor(Color.green)
                }
            else {
                Image(systemName: "circle")
                    .foregroundColor(Color.black)
                }
            
            }
            
            NavigationLink("Dismiss", destination: Welcome(message: "Thanks You"))
       
    
            
        }
    
        
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
            }
    }
    
}


