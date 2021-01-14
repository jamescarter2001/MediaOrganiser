//
//  ContentView.swift
//  MediaOrganiser
//
//  Created by James on 09/01/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentDirectory : String = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path
    
    @EnvironmentObject var userData : UserData
    
    let browserFileService : SystemBrowserFileService = SystemBrowserFileService()
    
    var body: some View {
        let browserData = browserFileService.getForPath(path: currentDirectory, groupMembers: userData.dict)
        NavigationView {
            List {
                NavigationLink(destination: BrowserView(browserData: browserData)) {
                    Image(systemName: "tray")
                        Text("System Browser")
                }
                NavigationLink(destination: BrowserView(browserData: [])) {
                    Image(systemName: "tray")
                        Text("RED")
                }
                    }
                    .listStyle(SidebarListStyle())
        }.navigationTitle(Text("Media Organiser")).toolbar {
            Button(action: {
                let dialog = NSOpenPanel();

                                    dialog.title                   = "Please select a directory:";
                                    dialog.showsResizeIndicator    = true;
                                    dialog.showsHiddenFiles        = false;
                                    dialog.allowsMultipleSelection = false;
                                    dialog.canChooseFiles = false;
                                    dialog.canChooseDirectories = true;
                                    
                                    if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
                                        self.currentDirectory = dialog.url!.path
                                    }
            }) {
                Image(systemName: "folder")
            }
            #if DEBUG
            Button(action: {
                
            }) {
                Image(systemName: "exclamationmark.square")
            }.foregroundColor(.orange)
            #endif
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
