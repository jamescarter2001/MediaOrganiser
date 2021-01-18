//
//  GroupBrowserContainerView.swift
//  MediaOrganiser
//
//  Created by James on 14/01/2021.
//

import SwiftUI

struct GroupBrowserContainerView: View {
    
    @EnvironmentObject private var userData : SaveData
    
    @State private var search : String = ""
    @State private var selection : Int = 0
    
    let group : String
    
    var body: some View {
        VStack {
            if (userData.groupData[group] != nil) {
                let browserData = userData.groupData[group]
                let queriedData = browserData!.filter({search.isEmpty || $0.name.contains(search) || $0.path.contains(search)})
                
                let category = EFileCategory(rawValue: group)
                BrowserView(browserData: (selection == 0 ? queriedData.sorted(by: {$0.name < $1.name}) : queriedData.sorted(by: {$0.size > $1.size})) , category: category != nil ? category : nil, allowTagging: true).navigationTitle("Media Organiser").toolbar {
                    QueryBarView(search: $search, selection: $selection)
                        Button(action:{
                            let alert = NSAlert()
                            alert.messageText = "\(group.capitalized)"
                            alert.informativeText = "Are you sure you want to delete this playlist?"
                            alert.addButton(withTitle: "Yes")
                            alert.addButton(withTitle: "No")
                            alert.alertStyle = NSAlert.Style.warning
                            
                            if (alert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn) {
                                userData.groupData.removeValue(forKey: group)
                                userData.objectWillChange.send()
                            }
                        }) {
                            Image(systemName: "trash").foregroundColor(.red)
                        }.help(Text("Delete"))
                    
                    SaveLoadStateBar()
                }
            }
        }
    }
}

struct GroupBrowserContainerView_Previews: PreviewProvider {
    static var previews: some View {
        GroupBrowserContainerView(group:"").environmentObject(SaveData())
    }
}
