//
//  ContentView.swift
//  MediaOrganiser
//
//  Created by James on 09/01/2021.
//

import SwiftUI

struct SystemBrowserContainerView: View {
    
    @State var currentDirectory : String = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path
    
    @EnvironmentObject var userData : UserData
    
    let browserFileService : SystemBrowserFileService = SystemBrowserFileService()
    
    var body: some View {
        let browserData = browserFileService.getForPath(path: currentDirectory, groupMembers: userData.data)
        
        BrowserView(browserData: browserData) .navigationTitle(Text("Media Organiser")).navigationSubtitle(currentDirectory).toolbar {
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
