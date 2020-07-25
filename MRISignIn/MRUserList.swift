//
//  MRUserList.swift
//  MRISignIn
//
//  Created by Andrew Connolly on 7/23/20.
//  Copyright © 2020 Andrew Connolly. All rights reserved.
//

import SwiftUI

struct MRUserList: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        HStack {
            NavigationView{
                List {
                    ForEach(userData.mrusers) { mruser in
                        if mruser.isLoggedIn {
                            MRUserRow(mruser: mruser)
                        }
                    }
                }
                .navigationBarTitle("Logged In")            }
            

            NavigationView{
                List {
                    ForEach(userData.mrusers) { mruser in
                        if !mruser.isLoggedIn {
                            MRUserRow(mruser: mruser)
                        }
                    }
                }
                .navigationBarTitle("Look up users")            }
           
        }
    }
}

struct MRUserList_Previews: PreviewProvider {
    static var previews: some View {
        MRUserList()
        .environmentObject(UserData())
        
        //ForEach(["iPad (7th Generation)"], id: \.self) { deviceName in MRUserList()
        //        .previewDevice(PreviewDevice(rawValue: deviceName))
        // .previewDisplayName(deviceName)
    }
}

