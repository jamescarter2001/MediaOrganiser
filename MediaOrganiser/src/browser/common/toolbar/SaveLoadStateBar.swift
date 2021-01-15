//
//  SaveLoadStateBar.swift
//  MediaOrganiser
//
//  Created by James on 15/01/2021.
//

import SwiftUI

struct SaveLoadStateBar: View {
    
    @EnvironmentObject private var saveData : SaveData
    
    var body: some View {
        HStack {
            Button(action:{
                let dialog = NSSavePanel();
                
                dialog.title                   = "Please select a directory:";
                dialog.showsResizeIndicator    = true;
                dialog.showsHiddenFiles        = false;
                dialog.allowedFileTypes = ["wzstate"]
                
                
                if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
                    let savePath : String = dialog.url!.path
                    JSONmediaFileHandler.EncodeAndSaveFile(dict: saveData.groupData, path: savePath)
                }
            }) {
                Image(systemName: "square.and.arrow.up")
            }.help(Text("Save state"))
            Button(action:{
                
                let dialog = NSOpenPanel();
                
                dialog.title                   = "Please select a directory:";
                dialog.showsResizeIndicator    = true;
                dialog.showsHiddenFiles        = false;
                dialog.allowedFileTypes = ["wzstate"]
                dialog.canChooseFiles = true;
                dialog.canChooseDirectories = false;
                
                if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
                    let savePath : String = dialog.url!.path
                    let savedDict : [String:[MediaFile]] = JSONmediaFileHandler.DecodeFile(path: savePath)
                    saveData.groupData = savedDict
                    saveData.objectWillChange.send()
                }
            }) {
                Image(systemName: "square.and.arrow.down")
            }
        }
    }
}

struct SaveLoadStateBar_Previews: PreviewProvider {
    static var previews: some View {
        SaveLoadStateBar()
    }
}
