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
    
    @State var showLoggedSessions = false
    @State var showData = false
    @State var today = Date()
    @State var timeInterval = 14
    
    var managedObjectContext: NSManagedObjectContext
    var sess: FetchedResults<Session>
    @ObservedObject var mruser: MRUser
    var contacts: FetchedResults<MRUser>
    
    var nusers: Int
    
    var loggedinMessage: String = "Is Currently Logged In?"
    let onComplete: (Bool) -> Void
    

    
    
    let hlp = Helper()
    
    var body: some View {
        
        HStack{
            VStack {
            Form {
                Section(header: Text("First Name")) {
                    Text(mruser.firstName)
                }
                Section(header: Text("Last Name")) {
                    Text(mruser.lastName)
                }
                Section(header: Text("Status")) {
                    if mruser.isLoggedIn {
                        Text("Is Currently Logged In.")
                    }
                    else {
                        Text("Not Logged in. \nLast seen:\n\(mruser.lastLogout)")
                    }
                }
                Button(action: {
                    if !self.showData {
                        self.showData = true
                        self.showLoggedSessions = true
                    }
                    else {
                        self.showLoggedSessions.toggle()
                        }
                }){
                    if self.showLoggedSessions {
                        Text("Show Recent Contacts")
                            .foregroundColor(Color.gray)
                    }
                    else {
                        Text("Show All Logged Sessions")
                            .foregroundColor(Color.gray)                    }
                }
                Section {
                    Button(action: {
                        self.mruser.isLoggedIn.toggle()
                        if self.mruser.isLoggedIn {
                            self.mruser.lastLogin = Date()
                            self.updateSession()
                        }
                        else {
                            self.mruser.lastLogout = Date()
                            self.updateSession()
                        }
                        self.saveContext()
                        self.dismiss()
                        }) //end button action
                    {
                        if mruser.isLoggedIn {
                            HStack {
                                
                                Text("LOG OUT")
                                    .fontWeight(.bold)
                                Spacer()
                                Image(systemName: "circle.fill")
                                    .foregroundColor(Color.green)
                            }
                            }
                        else {
                            HStack{
                                Text("LOG IN HERE")
                                    .fontWeight(.bold)
                                Spacer()
                                Image(systemName: "circle")
                                    .foregroundColor(Color.black)
                                }
                            }
                        } // end Log in Button View
                    } // end login Section
            } // end Form
            
            Button(action: dismiss) {
                    HStack{
                        Image(systemName: "clear")
                
                        Text("Dismiss")
                            .frame(alignment: .center)
                            .foregroundColor(Color.black)
                    }
                }
                .padding(.bottom, 20)
                .padding(.top, 20)
            } //end Vstack
            
            if self.showData {
                if self.showLoggedSessions {
                    VStack{
                        Spacer()
                        Text("Logged Sessions")
                            .font(.title)
                        if getNSess(mruser: mruser) > 0 {
                        
                            List {
                                ForEach(
                                ((0...(getNSess(mruser: self.mruser) - 1))), id: \.self  ) { ses in
                                   
                                    SessionRow(managedObjectContext: self.managedObjectContext,
                                               session: self.getSess(mruser: self.mruser)[ses],
                                               sessDate: self.getDate(sess: self.getSess(mruser: self.mruser)[ses]),
                                               curtime: self.getCurTime(),
                                               contacts: self.contacts
                                    ) }
                                } //end list
                        } // end if getSess
                    }.padding(.top, 10).padding(.bottom, 10) // end logged sessions vstack
                } // end if showLoggedSessions
                else {
                    
                    VStack{
                        
                        Text("Recent Contacts")
                            .font(.title)
                        
                        Text("From:\n\(getTwoWeeksPast(time: today))\n")
                        Text("To:\n\(today)\n")
                        
                        
                        
                        ContactTrace(contacts: getRecentContacts(beg: getTwoWeeksPast(time: self.today),
                                                                 fin: self.today))
                           
                        
                    }.padding(.top, 10).padding(.bottom, 10) // end recent contacts vstack
                    
                } // end else
                
                
                
            } //end if show Data
        } //end HStack
    } // end body

    
    func getTwoWeeksPast(time: Date) -> Date {
        let calendar = Calendar.current
        let components = DateComponents(day: -(self.timeInterval))
        let twoWeeksPast = calendar.date(byAdding: components, to: time)!
        return twoWeeksPast
        
    }
    
    func getCurTime() -> String {
        
        return hlp.getTime(time: Date(), style: "hour")
        
    }
    
    func getDate(sess: Session) -> [String] {
        var temp: String
        var ret: [String]
        temp = hlp.formatSessionDate(beg: sess.start, fin: sess.fin)
        temp = temp.components(separatedBy: "_Contacts")[0]
        ret = temp.components(separatedBy: "_")
        return ret
    }
    
    func getSess(mruser: MRUser) -> [Session] {
        var ret: [Session] = []
        for s in sess {
            if s.users.contains(mruser.id.uuidString) {
                ret.append(s)
            }
        }
        return ret
    }
    
    func getContacts(ses: Session) -> [String] {
        var ret: [String] = []
        
        for cont in self.contacts {
            if ses.users.contains(cont.id.uuidString) &&
                (cont.id.uuidString != self.mruser.id.uuidString)
            {
                ret.append("\(cont.firstName) \(cont.lastName)")
            }
        }
        
        return ret
        
    }
    
    func getRecentContacts(beg: Date, fin: Date) -> String {
        var firstDeg: String = "_"
        var sesContacts: [String] = []
        var recSess = false
        var tmp = ""
        
        for ses in getSess(mruser: self.mruser) {
            if !(ses.n <= 1 || ses.fin < beg || ses.start > fin)
            {
                sesContacts = getContacts(ses: ses)
                for c in sesContacts {
                    if !firstDeg.contains(c) {
                        tmp += "\(c),"
                        recSess = true
                    }
                }
                if recSess {
                    firstDeg += "~\(hlp.formatSessionDate(beg: ses.start, fin: ses.fin))"
                    firstDeg += tmp
                    recSess = false
                    tmp = ""
                    }
                }
            }
        return firstDeg
        }

    
    func getNSess(mruser: MRUser) -> Int {
        var ret: Int = 0
        
        for s in sess {
            if s.users.contains(mruser.id.uuidString) {
                ret += 1
            }
        }
        
        return ret
    }
    
    func saveContext() {
        //do {
        try! self.managedObjectContext.save()
        //} catch {
        //    print("Error saving managed object context: \(error)")
         //   }
    }
    func updateSession(){
        
        var c: String = "_"
        for contact in self.contacts {
            if contact.isLoggedIn {
                c.append(".\(contact.id.uuidString)")
            }
        }
        
        for sess in self.sess {
            if sess.isCur {
                sess.fin = Date()
                sess.isCur = false
            }
        }
        
        let newSess = Session(context: self.managedObjectContext)
        newSess.start = Date()
        newSess.fin = Date()
        newSess.id = UUID()
        newSess.users = c
        newSess.n = c.components(separatedBy: ".").count - 1
        newSess.isCur = true
            
        saveContext()
        
        
    }
    
    private func dismiss() {
        onComplete(false)
        
    }
    
}




