//
//  GroupBrowserContainerView.swift
//  MediaOrganiser
//
//  Created by James on 14/01/2021.
//

import SwiftUI

struct GroupBrowserContainerView: View {
    
    @EnvironmentObject var userData : UserData
    @State var search : String = ""
    let group : String
    
    @State private var selection : Int = 0
    let pickerOptions = ["Alphabetically", "Size"]
    
    var body: some View {
        if (userData.dict[group] != nil) {
            let browserData = userData.dict[group]
            let queriedData = browserData!.filter({search.isEmpty || $0.name.contains(search) || $0.path.contains(search)})
            
            let category = EFileGroup(rawValue: group)
            BrowserView(browserData: (selection == 0 ? queriedData.sorted(by: {$0.name < $1.name}) : queriedData.sorted(by: {$0.size > $1.size})) , category: category != nil ? category : nil).toolbar {
                QueryView(search: $search, selection: $selection)
                if (category == nil) {
                    /*Picker(selection: $selection, label: Text("AAAA")) {
                        ForEach(0 ..< pickerOptions.count) {
                            Text(pickerOptions[$0])
                        }
                    }
                    TextField("Search", text: $search).frame(width: 300, height:30).padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 0)).textFieldStyle(RoundedBorderTextFieldStyle()).help(Text("Search for files in directory"))*/
                    Button(action:{
                        let alert = NSAlert()
                        alert.messageText = "\(group.capitalized)"
                        alert.informativeText = "Are you sure you want to delete this playlist?"
                        alert.addButton(withTitle: "Yes")
                        alert.addButton(withTitle: "No")
                        alert.alertStyle = NSAlert.Style.warning
                        
                        if (alert.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn) {
                            userData.dict.removeValue(forKey: group)
                            userData.objectWillChange.send()
                        }
                    }) {
                        Image(systemName: "trash").foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct GroupBrowserContainerView_Previews: PreviewProvider {
    static var previews: some View {
        GroupBrowserContainerView(group:"").environmentObject(UserData())
    }
}
