//
//  BrowserView.swift
//  MediaOrganiser
//
//  Created by James on 11/01/2021.
//

import SwiftUI

struct BrowserView: View {
    
    let browserData : [BrowserFile]
    let category : EFileCategory?
    
    @State private var selectedFiles = Set<BrowserFile>()
    @EnvironmentObject private var userData : SaveData
    
    var body: some View {
        VStack {
            if (browserData.count != 0) {
                VStack {
                    List(browserData, id: \.self, selection: $selectedFiles) { item in
                        BrowserItemView(name: item.name, path: item.path, size: item.size, type: item.type, comment: item.comment, category: category != nil ? category : nil, imagePath: item.imagePath)
                            .contextMenu {
                                if (!selectedFiles.isEmpty) {
                                    Section {
                                        Menu("Add to Category") {
                                            Section {
                                                ForEach(EFileCategory.allCases, id: \.self) { i in
                                                    if (i != EFileCategory.none) {
                                                    Button(action: {
                                                        selectedFiles.forEach { selection in
                                                            
                                                            var existing : [BrowserFile] = userData.groupData[i.rawValue] ?? []
                                                            if (!existing.contains(selection)) {
                                                                existing.append(selection)
                                                            }
                                                            userData.groupData[i.rawValue] = existing
                                                        }
                                                        selectedFiles = Set<BrowserFile>()
                                                        userData.objectWillChange.send()
                                                    }) {
                                                        Text(i.rawValue.capitalized)
                                                    }
                                                }
                                                }
                                            }
                                        }
                                        Menu("Remove from Category") {
                                            let keys = EFileCategory.allCases
                                            ForEach(keys, id: \.self) { i in
                                                if (i != EFileCategory.none) {
                                                Button(action: {
                                                    selectedFiles.forEach { selection in
                                                        for key in keys {
                                                            let groupData = userData.groupData[key.rawValue]?.filter({$0.path != selection.path})
                                                            userData.groupData[key.rawValue] = groupData
                                                        }
                                                    }
                                                    selectedFiles = Set<BrowserFile>()
                                                    userData.objectWillChange.send()
                                                }) {
                                                    Text(i.rawValue.capitalized)
                                                }
                                                }
                                            }
                                        }
                                    }
                                    Menu("Add to Playlist") {
                                        Button(action: {
                                            let alert = NSAlert()
                                            alert.messageText = "Enter playlist name"
                                            alert.addButton(withTitle: "Submit")
                                            alert.addButton(withTitle: "Cancel")
                                            let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
                                            textField.stringValue = ""
                                            alert.accessoryView = textField
                                            
                                            if (alert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn) {
                                                print("Done: \(textField.stringValue)")
                                                let newGroup : [BrowserFile] = Array(selectedFiles)
                                                userData.groupData[textField.stringValue.lowercased()] = newGroup
                                                userData.objectWillChange.send()
                                            }
                                        }) {
                                            Text("New Playlist")
                                        }
                                        Section {
                                            ForEach(Array(userData.groupData.keys), id: \.self) { i in
                                                if EFileCategory(rawValue: i) == nil {
                                                    Button(action: {
                                                        selectedFiles.forEach { selection in
                                                            
                                                            var existing : [BrowserFile] = userData.groupData[i] ?? []
                                                            if (!existing.contains(selection)) {
                                                                existing.append(selection)
                                                            }
                                                            userData.groupData[i] = existing
                                                        }
                                                        selectedFiles = Set<BrowserFile>()
                                                        userData.objectWillChange.send()
                                                    }) {
                                                        Text(i.capitalized)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    Menu("Remove from Playlist") {
                                        let keys = Array(userData.groupData.keys)
                                        ForEach(keys, id: \.self) { i in
                                            if EFileCategory(rawValue: i) == nil {
                                            Button(action: {
                                                selectedFiles.forEach { selection in
                                                    
                                                    for key in keys {
                                                        let groupData = userData.groupData[key]?.filter({$0.path != selection.path})
                                                        userData.groupData[key] = groupData
                                                    }
                                                }
                                                selectedFiles = Set<BrowserFile>()
                                                userData.objectWillChange.send()
                                            }) {
                                                Text(i.capitalized)
                                            }
                                            }
                                        }
                                    }
                                    Section {
                                        Button(action: {
                                            
                                            let alert = NSAlert()
                                            alert.messageText = "Enter comment"
                                            alert.addButton(withTitle: "Submit")
                                            alert.addButton(withTitle: "Cancel")
                                            let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
                                            textField.stringValue = selectedFiles.first?.comment ?? ""
                                            alert.accessoryView = textField
                                            
                                            if (alert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn) {
                                                
                                                let keys = Array(userData.groupData.keys)
                                                selectedFiles.forEach { i in
                                                    for key in keys {
                                                        
                                                        let matchingFiles : [BrowserFile] = userData.groupData[key]!.filter({$0.path == i.path})
                                                        
                                                        userData.groupData[key] = userData.groupData[key]!.filter({$0.path != i.path})
                                                        
                                                        matchingFiles.forEach { match in
                                                            var matchCopy = match
                                                            matchCopy.comment = textField.stringValue
                                                            userData.groupData[key]?.append(matchCopy)
                                                        }
                                                    }
                                                }
                                                userData.objectWillChange.send()
                                            }
                                        }) {
                                            Text("Edit Comment")
                                        }
                                        Button(action: {
                                            
                                            let dialog = NSOpenPanel();
                                            
                                            dialog.title                   = "Please select a directory:";
                                            dialog.showsResizeIndicator    = true;
                                            dialog.showsHiddenFiles        = false;
                                            dialog.allowsMultipleSelection = false;
                                            dialog.canChooseFiles = true;
                                            dialog.canChooseDirectories = false;
                                            dialog.allowedFileTypes = ["png", "jpg"]
                                            
                                            if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
                                                print(dialog.url!.path)
                                                
                                                let keys = Array(userData.groupData.keys)
                                                
                                                selectedFiles.forEach { i in
                                                    for key in keys {
                                                        
                                                        let matchingFiles : [BrowserFile] = userData.groupData[key]!.filter({$0.path == i.path})
                                                        
                                                        userData.groupData[key] = userData.groupData[key]!.filter({$0.path != i.path})
                                                        
                                                        matchingFiles.forEach { match in
                                                            var matchCopy = match
                                                            matchCopy.imagePath = dialog.url!.path
                                                            userData.groupData[key]?.append(matchCopy)
                                                        }
                                                    }
                                                }
                                                self.userData.objectWillChange.send()
                                            }
                                        }) {
                                            Text("Edit Image")
                                        }
                                    }
                                }
                            }
                    }.listStyle(SidebarListStyle())
                }
            } else {
                VStack {
                    Image(systemName: "folder").resizable().scaledToFit().frame(width: 100, height: 100, alignment: .center).foregroundColor(.gray)
                    Text("No matching files found in the selected directory.")
                        .multilineTextAlignment(.center).foregroundColor(.gray)
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        BrowserView(browserData: [], category: nil)
    }
}
