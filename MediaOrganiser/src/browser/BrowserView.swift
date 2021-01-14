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
                                    selectedFiles.forEach { selection in
                                        
                                        userData.data = userData.data.filter({$0.path != selection.path})
                                        
                                    var item = selection
                                        item.group = i
                                        userData.data.append(item)
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
            VStack {
                Image(systemName: "folder").resizable().scaledToFit().frame(width: 100, height: 100, alignment: .center).foregroundColor(.gray)
                Text("No matching files found in the selected directory.")
                .multilineTextAlignment(.center).foregroundColor(.gray)
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        BrowserView(browserData: [])
    }
}
