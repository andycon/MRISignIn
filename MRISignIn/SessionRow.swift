//
//  SessionRow.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 8/13/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//

import SwiftUI
import CoreData

struct SessionRow: View {
    var managedObjectContext: NSManagedObjectContext
    @State var linkToSessDetail: Bool = false
    let session: Session
    let sessDate: [String]
    let curtime: String
    let contacts: FetchedResults<MRUser>
    
    let hlp = Helper()
    
    func onComplete(returnBool: Bool) {
        
    }
    
    var body: some View {
        HStack{
            VStack{
                Text(sessDate[0])
                    .fontWeight(.bold)
                Text(sessDate[1])
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                Text("\(sessDate[2]) '\(sessDate[3])")
                    .font(.footnote)
                }
            Spacer()
            Text(sessDate[4])
                .font(.headline)
            Spacer()
            if session.isCur {
                Text(curtime)
                    .font(.headline)
                    .foregroundColor(Color.green)
            }
            else {
                Text(sessDate[5])
                    .font(.headline)
            }
            Spacer()
            Button(action: { self.linkToSessDetail.toggle() } ) {
                if session.n == 0 {
                    Image(systemName: "moon.zzz")
                        .foregroundColor(Color.gray)
                }
                else if session.n == 1 {
                    Image(systemName: "person.fill")
                        .foregroundColor(Color.green)
                }
                else if session.n == 2 {
                    Image(systemName: "person.2.fill")
                        .foregroundColor(Color.green)
                }
                else if session.n == 3 {
                        Image(systemName: "person.3.fill")
                            .foregroundColor(Color.green)
                    }
                else {
                    HStack{
                    Image(systemName: "person.3.fill")
                        .foregroundColor(Color.red)
                    Text("+")
                        .font(.headline)
                        .foregroundColor(Color.red)
                    }

                }
            }
            .sheet(isPresented: $linkToSessDetail) {
                SessionDetail(contacts: self.getContacts(ses: self.session),
                              sessDate: self.sessDate) {
                    _ in self.linkToSessDetail = false
                }
                              
            }
        }
    
          
        
        
        
      
         
    }
            
    
    func getContacts(ses: Session) -> [String] {
        var ret: [String] = []
        
        for cont in self.contacts {
            if ses.users.contains(cont.id.uuidString) {
                ret.append("\(cont.firstName) \(cont.lastName)")
            }
        }
        
        return ret
        
    }
    
}
