//
//  TestView.swift
//  MediaOrganiser
//
//  Created by James on 11/01/2021.
//

import SwiftUI

struct BrowserView: View {
    
    let browserData : [BrowserFile]
    
    @State private var selectedFiles = Set<BrowserFile>()
    @EnvironmentObject private var userData : UserData
    
    var body: some View {
        VStack {
        if (browserData.count != 0) {
            VStack {
            List(browserData, id: \.self, selection: $selectedFiles) { item in
                BrowserItemView(name: item.name, path: item.path, size: item.size, type: item.type, comment: item.comment)
                    .contextMenu {
                        if (!selectedFiles.isEmpty) {
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
                                            userData.dict[textField.stringValue.lowercased()] = newGroup
                                            userData.objectWillChange.send()
                                        }
                                    }) {
                                        Text("New Playlist")
                                    }
                                Section {
                                ForEach(Array(userData.dict.keys), id: \.self) { i in
                                    Button(action: {
                                        selectedFiles.forEach { selection in
                                            
                                            var existing : [BrowserFile] = userData.dict[i] ?? []
                                            if (!existing.contains(selection)) {
                                                existing.append(selection)
                                            }
                                            userData.dict[i] = existing
                                        }
                                        selectedFiles = Set<BrowserFile>()
                                        userData.objectWillChange.send()
                                    }) {
                                        Text(i.capitalized)
                                    }
                                }
                                }
                            }
                            Menu("Remove from Playlist") {
                                let keys = Array(userData.dict.keys)
                                ForEach(keys, id: \.self) { i in
                                    Button(action: {
                                        selectedFiles.forEach { selection in
                                            
                                            for key in keys {
                                                let groupData = userData.dict[key]?.filter({$0.path != selection.path})
                                                userData.dict[key] = groupData
                                            }
                                        }
                                        selectedFiles = Set<BrowserFile>()
                                        userData.objectWillChange.send()
                                    }) {
                                        Text(i.capitalized)
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
                                        
                                        let keys = Array(userData.dict.keys)
                                        selectedFiles.forEach { i in
                                            for key in keys {
                                                
                                                let matchingFiles : [BrowserFile] = userData.dict[key]!.filter({$0.path == i.path})
                                                
                                                userData.dict[key] = userData.dict[key]!.filter({$0.path != i.path})
                                                
                                                matchingFiles.forEach { match in
                                                    var matchCopy = match
                                                    matchCopy.comment = textField.stringValue
                                                    userData.dict[key]?.append(matchCopy)
                                                }
                                            }
                                        }
                                        userData.objectWillChange.send()
                                    }
                                    
                                    //---
                                    
                                    
                                }) {
                                    Text("Edit Comment")
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
        BrowserView(browserData: [])
    }
}
