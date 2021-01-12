//
//  ContentView.swift
//  MediaOrganiser
//
//  Created by James on 09/01/2021.
//

import SwiftUI

let test : [String] = ["tray"]

struct ContentView: View {
    
    @State var currentDirectory : String = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path
    
    let browserFileService : BrowserFileService = BrowserFileService()
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: BrowserView(browserData: browserFileService.getForPath(path: currentDirectory))) {
                    Image(systemName: "tray")
                        Text("System Browser")
                }
                    }
                    .listStyle(SidebarListStyle())
        }.navigationTitle(Text("Media Organiser")).navigationSubtitle(currentDirectory).toolbar {
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
