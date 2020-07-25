//
//  ContentView.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 7/23/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//

import SwiftUI
import Foundation

func getTime() -> String {
    
    let time = Date()
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .short
    let dateTimeString = formatter.string(from: time)
    
    return dateTimeString
}

struct MRUserRow: View {
    @EnvironmentObject var userData: UserData
    var mruser: MRUser
    var mruserIndex: Int {
        userData.mrusers.firstIndex(where: { $0.id == mruser.id })!
    }
    
    //var nameColor = .gray
    
    //if self.userData.mrusers[self.mruserIndex].isLoggedIn {
    
    
    var body: some View {
        HStack {

                if self.userData.mrusers[self.mruserIndex].isLoggedIn {
                    mruser.image
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack {
                        Text("\(mruser.firstName) \(mruser.lastName)")
                            .font(.headline)
                            .foregroundColor(.black)
                    
                        Text(
                            "Logged in: \(self.userData.mrusers[self.mruserIndex].lastLogin)"
                            )
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                else {
                    mruser.image
                        .resizable()
                        .frame(width: 50, height: 50)
                        .colorInvert()
                    VStack {
                    Text("\(mruser.firstName) \(mruser.lastName)")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text(
                        "Logged out: \(self.userData.mrusers[self.mruserIndex].lastLogout)"
                        )
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    }
            }
            Spacer()
            Button(action : {
                self.userData.mrusers[self.mruserIndex].isLoggedIn.toggle()
                if self.userData.mrusers[self.mruserIndex].isLoggedIn {
                    self.userData.mrusers[self.mruserIndex].lastLogin = getTime()
                    }
                else {
                    self.userData.mrusers[self.mruserIndex].lastLogout = getTime()
                    
                    }
                }) {
                    if self.userData.mrusers[self.mruserIndex].isLoggedIn {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Color.green)
                    }
                    else {
                        Image(systemName: "circle")
                            .foregroundColor(Color.black)
                    }
                
                }
        }
        //.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MRUserRow(mruser: mruserData[0])
            MRUserRow(mruser: mruserData[4])
        }
        //.previewLayout(.fixed(width: 500, height: 50))
        
    }
}
