//
//  TestView.swift
//  MediaOrganiser
//
//  Created by James on 10/01/2021.
//

import SwiftUI

struct BrowserView: View {
    
    let browserData : [BrowserFile]
    
    var body: some View {
        if (browserData.count != 0) {
        List {
            ForEach(browserData) { item in
                BrowserItemView(name: item.name, path: item.path, type: item.type, group: item.group)
                }
            }
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
