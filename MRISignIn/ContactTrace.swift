//
//  ContactTrace.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 8/17/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//

import SwiftUI

struct ContactTrace: View {
    let contacts: String
    //let sess: FetchedResults<Session>
    //let contacts: FetchedResults<MRUser>
    
    var body: some View {
        VStack {
            
            List {
                ForEach(
                    (getSessions(sess: self.contacts)), id: \.self  ) { cont in
                    
                        Text(cont)
                
                
                }
            }
            
        }
            
            
        }
    
    

    
    func getSessions(sess: String) -> [String] {
        var contacts: [String] = []
        var conts: [String]
        var tmp: String
        
        var tmpA: [String]
        var tmpB: [String]
        
        
        let segs: [String] = sess.components(separatedBy: "~")
        for i in (1...(segs.count-1)) {
            tmpA = segs[i].components(separatedBy: "_Contacts::")
            tmpB = tmpA[0].components(separatedBy: "_")
            conts = tmpA[1].components(separatedBy: ",")
            tmp = "\(tmpB[2]) \(tmpB[1]) \(tmpB[5]) "
            for c in (0...(conts.count - 2)) {
                contacts.append("\(tmp) \(conts[c])")
            }
        }
        return contacts
        
    }
}

