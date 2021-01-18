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
    
    @State private var selection : Int = 0
    
    @EnvironmentObject private var userData : SaveData
    
    let systemMediaFileService : SystemMediaFileService = SystemMediaFileService()
    
    var body: some View {
        let browserData = systemMediaFileService.getForPath(path: currentDirectory, groupData: userData.groupData)
        let queriedData = browserData.filter({search.isEmpty || $0.name.contains(search) || $0.path.contains(search)})
        
        BrowserView(browserData: selection == 0 ? queriedData.sorted(by: {$0.name < $1.name}) : queriedData.sorted(by: {$0.size > $1.size}), category: nil, allowTagging: false).navigationTitle(Text("Media Organiser")).navigationSubtitle(currentDirectory).toolbar {
            
            QueryBarView(search: $search, selection: $selection)
            
            Button(action: {
                let dialog = NSOpenPanel();
                
                dialog.title                   = "Please select a directory:";
                dialog.showsResizeIndicator    = true;
                dialog.showsHiddenFiles        = false;
                dialog.allowsMultipleSelection = false;
                dialog.canChooseFiles = false;
                dialog.canChooseDirectories = true;
                
                if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
                    print(dialog.url!.path)
                    self.currentDirectory = dialog.url!.path
                }
            }) {
                Image(systemName: "folder")
            }.help(Text("Change directory"))
            SaveLoadStateBar()
            #if DEBUG
            Button(action: {
                userData.groupData = JSONmediaFileHandler.DecodeFile(path: "/Users/james/Desktop/output.wzstate")
                userData.objectWillChange.send()
            }) {
                Image(systemName: "exclamationmark.square")
            }.foregroundColor(.orange).help(Text("Debug"))
            #endif
        }
    }
}

struct SystemBrowserContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SystemBrowserContainerView().environmentObject(SaveData())
    }
}
