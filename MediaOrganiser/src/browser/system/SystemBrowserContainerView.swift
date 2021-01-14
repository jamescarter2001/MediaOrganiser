//
//  ContentView.swift
//  MediaOrganiser
//
//  Created by James on 09/01/2021.
//

import SwiftUI

struct SystemBrowserContainerView: View {
    
    @State private var currentDirectory : String = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path
    @State private var search: String = ""
    
    @EnvironmentObject var userData : UserData
    
    let browserFileService : SystemBrowserFileService = SystemBrowserFileService()
    
    var body: some View {
        let browserData = browserFileService.getForPath(path: currentDirectory, groupMembers: userData.data)
        let filteredData = browserData.filter({$0.name.contains(search) || $0.path.contains(search)})
                
        BrowserView(browserData: search.isEmpty ? browserData : filteredData ) .navigationTitle(Text("Media Organiser")).navigationSubtitle(currentDirectory).toolbar {
            TextField("Search", text: $search).frame(width: 300, height:30).padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 0)).textFieldStyle(RoundedBorderTextFieldStyle())
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
                let encoder : JSONFileHandler = JSONFileHandler<BrowserFile>()
                encoder.encodeAndSaveFile(array: userData.data, path: "")
            }) {
                Image(systemName: "exclamationmark.square")
            }.foregroundColor(.orange)
            #endif
        }
    }
}

struct SystemBrowserContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SystemBrowserContainerView()
    }
}
