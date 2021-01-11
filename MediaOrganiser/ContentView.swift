//
//  ContentView.swift
//  MediaOrganiser
//
//  Created by James on 09/01/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentDirectory : String = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path
    
    let browserFileProvider : BrowserFileService = BrowserFileService()
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: BrowserView(browserData: browserFileProvider.getForPath(path: currentDirectory))) {
                    Image(systemName: "tray")
                        Text("System Browser")
                }
                    }
                    .listStyle(SidebarListStyle())
        }.navigationTitle(Text("Media Organiser")).toolbar {
            HStack {
                Text(self.currentDirectory).frame(width: 500, height: 10, alignment: .trailing).foregroundColor(.gray)
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
                    Label("Change Directory", systemImage: "folder")
                }
                #if DEBUG
                Button(action: {
                    
                }) {
                    Image(systemName: "exclamationmark.square").foregroundColor(.orange)
                }
                #endif
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
