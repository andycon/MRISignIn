//
//  MRUserList.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 7/23/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//

import SwiftUI
import CoreData

struct MRUserList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    // @EnvironmentObject var userData: UserData
    //@State var mrusers: [MRUser] = []
    @State var isPresented = false
    @State var showingAlert = false
    @State var showUserDetail = false

    //@State var selectUser = false
    //@State private var refresh = false
    //private var didSave = NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)
    //var curSess: Session
    
    
    
    @FetchRequest(
         entity: Session.entity(),
         sortDescriptors: [
           NSSortDescriptor(keyPath: \Session.start, ascending: false)
         ]
         //predicate: NSPredicate(format: "isCur == %@", NSNumber(value: true))
       ) var sess: FetchedResults<Session>
    
    @FetchRequest(
      entity: MRUser.entity(),
      sortDescriptors: [
        NSSortDescriptor(keyPath: \MRUser.lastName, ascending: true)
      ],
      predicate: NSPredicate(format: "isLoggedIn == %@", NSNumber(value: true))
    ) var inmrusers: FetchedResults<MRUser>
    
    @FetchRequest(
      entity: MRUser.entity(),
      sortDescriptors: [
        NSSortDescriptor(keyPath: \MRUser.lastName, ascending: true)
      ]
      //predicate: NSPredicate(format: "isLoggedIn == %@", NSNumber(value: false))
    ) var allmrusers: FetchedResults<MRUser>
    

    var body: some View {
        

          
        NavigationView {
            HStack {
            VStack {
                List {
                    ForEach(inmrusers, id: \.firstName) { mruser in
                        HStack {
                                 VStack(alignment: .leading) {
                                    
                                     Text(mruser.firstName)
                                     Text(mruser.lastName)
                                 }
                                 Spacer()
                                 Image(systemName: "circle.fill")
                                         .foregroundColor(Color.green)
                             }
                        }
                        .onDelete(perform: self.deleteUser)
                    }
                    .navigationBarTitle(Text("Logged In"))
                    .navigationBarItems(leading:
                        Button(action: {}) { Text("?")},
                        trailing:
                            Button(action: { self.isPresented.toggle() }) {
                                Image(systemName: "plus")
                            })
                Text("All MRUsers")
                    .frame(width: 295, alignment: .topLeading)
                    .font(.title)
                List {
                    ForEach(allmrusers, id: \.firstName) { mruser in
                        
                        MRUserRow(managedObjectContext: self.managedObjectContext, sess: self.sess,
                                  mruser: mruser, contacts: self.allmrusers, nusers: self.inmrusers.count)
                        
                    }.onDelete(perform: self.deleteUser)
                    
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("User already exists!"),
                        message: Text("Choose name from All MRUsers list.")
                    )
                }
                }
            }
            
            
            
          if self.isPresented {
                AddUser(contacts: self.allmrusers) { firstName, lastName in
                if !(firstName == "John" && lastName == "Deere") {
                    if !(firstName == "Ned" && lastName == "Smedley") {
                        self.addUser(firstName: firstName, lastName: lastName)
                    }
                    else {
                        self.showingAlert = true
                    }
                }
                 
                    self.isPresented = false
                }
            }
            else {
                Welcome()
            }
        }
           
    }
       
       
        
    
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
            }
    }
    
    func addUser(firstName: String, lastName: String) {
              
        let newUser = MRUser(context: managedObjectContext)
        
        
        newUser.firstName = firstName
        newUser.lastName = lastName
        newUser.isLoggedIn = false
        newUser.createdOn = Date()
        newUser.lastLogin = Date()
        newUser.lastLogout = Date()
        newUser.id = UUID()
        newUser.sessions = ""
        newUser.sessionContacts = ""
        newUser.nSessions = 0
        saveContext()
    }
    

    
    func deleteUser(at offsets: IndexSet){
        
        offsets.forEach { index in
          let user = self.allmrusers[index]
          self.managedObjectContext.delete(user)
        }
        
        saveContext()
        
    }
    
    func signOut(at offsets: IndexSet) {
        
        offsets.forEach { index in
            let user = self.inmrusers[index]
            user.isLoggedIn = false
            saveContext()
        }
       
    }
    
    
    
}



struct MRUserList_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return MRUserList().environment(\.managedObjectContext, context)
            
    }
        
}
        
    

