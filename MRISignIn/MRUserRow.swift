//
//  ContentView.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 7/23/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//

import SwiftUI
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
    var managedObjectContext: NSManagedObjectContext
    var sess: FetchedResults<Session>
    @ObservedObject var mruser: MRUser
    var contacts: FetchedResults<MRUser>
    @State var linkToDetail: Bool = false
    var nusers: Int

  
    func onComplete(returnBool: Bool) {
        
    }
    
    var body: some View {
       
        
        //let dest = { UserDetailView(mruser: self.mruser)
         //   .environment(\.managedObjectContext, self.managedObjectContext) as! Bool ?? linkToDetail : {} }
        
        /*NavigationLink(destination:
            UserDetailView(mruser: self.mruser)
                .environment(\.managedObjectContext, self.managedObjectContext)
            )
        */
        //NavigationView{
        
           HStack {
            
        
                    VStack(alignment: .leading) {
                        Text(mruser.firstName)
                        Text(mruser.lastName)
                    }
     
                    Spacer()
                    
            Button(action: { self.linkToDetail.toggle() } ) {
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
                .sheet(isPresented: $linkToDetail) {
                    UserDetailView(managedObjectContext: self.managedObjectContext, sess: self.sess,
                                   mruser: self.mruser, contacts: self.contacts, nusers: self.nusers)
                    {_ in
                        self.linkToDetail = false
                    }
                }
    }
        
        
}
        
    
   
    
    
    
  
