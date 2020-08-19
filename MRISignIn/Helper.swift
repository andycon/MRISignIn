//
//  Helper.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 8/13/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

class Helper{
    
    
    func nContacts(session: String) -> String {
        return parseSession(session: session, arg: "nContacts")[1]
    }
    
    func parseSession(session: String, arg: String) -> [String] {
        var res: [String] = []
        var substr: String
        
        switch arg {
        case "nContacts":
            substr = session.components(separatedBy: "[")[0]
            res = substr.components(separatedBy: "::")
        case "dayTime":
            substr = session.components(separatedBy: "_Contacts")[0]
            res = substr.components(separatedBy: "_")
        case "contacts":
            substr = session.components(separatedBy: "[")[1]
            res = substr.components(separatedBy: ".")
        default:
            res = session.components(separatedBy: "_")
        
            
        }
        return res
        
    }
    
    func formatContact(contact: MRUser) -> String {
        var res: String = ""
        res += "\(contact.firstName)~\(contact.lastName)~"
        res += "\(contact.id.uuidString)"
        return res
        
    }
    
    func formatSessionDate(beg: Date, fin: Date) -> String {
        var res: String = ""
        
        res += "\(getTime(time: fin, style: "dayOfWeek"))_"
        res += "\(getTime(time: fin, style: "dayOfMonth"))_"
        res += "\(getTime(time: fin, style: "month"))_"
        res += "\(getTime(time: fin, style: "year"))_"
        res += "\(getTime(time: beg, style: "hour"))_"
        res += "\(getTime(time: fin, style: "hour"))_Contacts::"
        
        return res
        
    }
    
    func getTime(time: Date, style: String) -> String {
        
        var retStrng: String
        let formatter = DateFormatter()
        formatter.weekdaySymbols = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
        formatter.monthSymbols = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        
        switch style {
        case "day":
            formatter.dateStyle = .full
            formatter.timeStyle = .none
            retStrng = formatter.string(from: time)
            
        case "dayOfWeek":
            formatter.dateStyle = .full
            retStrng = formatter.string(from: time)
            retStrng = retStrng.components(separatedBy: ",")[0]
        case "dayOfMonth":
            formatter.dateStyle = .full
            retStrng = formatter.string(from: time)
            retStrng = retStrng.components(separatedBy: ", ")[1]
            retStrng = retStrng.components(separatedBy: " ")[1]
        case "month":
            formatter.dateStyle = .full
            retStrng = formatter.string(from: time)
            retStrng = retStrng.components(separatedBy: ", ")[1]
            retStrng = retStrng.components(separatedBy: " ")[0]
        case "hour":
            formatter.timeStyle = .short
            retStrng = formatter.string(from: time)
        case "year":
            formatter.dateStyle = .short
            retStrng = formatter.string(from: time)
            retStrng = retStrng.components(separatedBy: "/")[2]
            
        default:
                formatter.timeStyle = .short
                formatter.dateStyle = .short
                retStrng = formatter.string(from: time)
        
          
        }
        
        return retStrng
    }
    
}
