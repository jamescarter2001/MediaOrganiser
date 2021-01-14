//
//  GroupBrowserContainerView.swift
//  MediaOrganiser
//
//  Created by James on 14/01/2021.
//

import SwiftUI

struct GroupBrowserContainerView: View {
    
    @EnvironmentObject var userData : UserData
    let group : String
    
    var body: some View {
        if (userData.dict[group] != nil) {
        BrowserView(browserData: userData.dict[group] ?? []).toolbar {
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

struct GroupBrowserContainerView_Previews: PreviewProvider {
    static var previews: some View {
        GroupBrowserContainerView(group:"")
    }
}
