//
//  TestView.swift
//  MediaOrganiser
//
//  Created by James on 10/01/2021.
//

import SwiftUI

struct BrowserView: View {
    
    let browserData : [BrowserFile]
    
    @State var selectedFiles = Set<BrowserFile>()
    @EnvironmentObject var userData : UserData
    
    var body: some View {
        
        if (browserData.count != 0) {
            
            List(browserData, id: \.self, selection: $selectedFiles) { item in
                BrowserItemView(name: item.name, path: item.path, size: item.size, type: item.type, group: item.group)
                    .contextMenu {
                    if (!selectedFiles.isEmpty) {
                    Menu("Add to Group") {
                        ForEach(EFileGroup.allCases, id: \.self) { i in
                                Button(action: {
                                    print(selectedFiles)
                                    print("-----")
                                    selectedFiles.forEach { selection in
                                    var item = selection
                                        item.group = i
                                        
                                        var test : Bool = false
                                        
                                        userData.data.forEach { entry in
                                            if entry.path == selection.path {
                                                test.toggle()
                                            }
                                        }
                                        
                                        userData.data.append(item)
                                        
                                        if (i == EFileGroup.none) {
                                            userData.data = userData.data.filter({$0.path != selection.path})
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
            }.listStyle(SidebarListStyle())
        } else {
            Image(systemName: "folder").resizable().scaledToFit().frame(width: 100, height: 100, alignment: .center).foregroundColor(.gray)
            Text("No matching files found in the selected directory.")
                .multilineTextAlignment(.center).foregroundColor(.gray)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        BrowserView(browserData: [])
    }
}
