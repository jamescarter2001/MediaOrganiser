//
//  MainView.swift
//  MediaOrganiser
//
//  Created by James on 13/01/2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: SystemBrowserContainerView()) {
                    Image(systemName: "tray")
                        Text("System Browser")
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
