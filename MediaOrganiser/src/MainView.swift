//
//  MainView.swift
//  MediaOrganiser
//
//  Created by James on 13/01/2021.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var userData : UserData
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("System")) {
                NavigationLink(destination: SystemBrowserContainerView()) {
                    Image(systemName: "tray")
                        Text("System Browser")
                }
                }
                Section(header: Text("Groups")) {
                ForEach(EFileGroup.allCases, id: \.self) { group in
                    if (group != EFileGroup.none) {
                    NavigationLink(destination: BrowserView(browserData: userData.data.filter{$0.group == group})) {
                        FileGroupCircleView(fileGroup: group).frame(width: 17.5, height: 17.5)
                        Text(group.rawValue.capitalized)
                    }
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
        MainView()
    }
}
