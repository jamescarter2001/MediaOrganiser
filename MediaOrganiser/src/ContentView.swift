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
    
    let browserFileService : BrowserFileService = BrowserFileService()
    
    var body: some View {
        let browserData = browserFileService.getForPath(path: currentDirectory, groupMembers: userData.data)
        ForEach (userData.data, id: \.self) { i in
        //Text("\(i.name)")
        }
        NavigationView {
            List {
                NavigationLink(destination: BrowserView(browserData: browserData)) {
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
            Button(action: {
                userData.data.append(BrowserFile(name: "BBBB", path: "BB/BB/BB", type: EFileType.mp3, group: EFileGroup.blue))
                userData.objectWillChange.send()
            }) {
                Image(systemName: "pencil.and.outline")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
