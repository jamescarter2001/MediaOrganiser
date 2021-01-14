//
//  MainView.swift
//  MediaOrganiser
//
//  Created by James on 13/01/2021.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var userData : UserData
    @State private var selection : Int? = 0
    
    var body: some View {
        NavigationView {
            List(selection: $selection) {
                Section(header: Text("System")) {
                    NavigationLink(destination: SystemBrowserContainerView()) {
                        Image(systemName: "tray")
                        Text("System Browser")
                    }.tag(0)
                }
                Section(header: Text("Playlists")) {
                    ForEach(Array(userData.dict.keys), id: \.self) { group in
                        NavigationLink(destination: GroupBrowserContainerView(group: group)) {
                                Text(group.capitalized)
                        }
                    }
                }
            }
            Text("Select a group to begin.")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(UserData())
    }
}
