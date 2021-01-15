//
//  QueryView.swift
//  MediaOrganiser
//
//  Created by James on 14/01/2021.
//

import SwiftUI

struct QueryBarView : View {
    
    @Binding var search : String
    @Binding var selection : Int
    let pickerOptions = ["Alphabetically", "Size"]
    
    var body : some View {
        Text("Sort:").foregroundColor(.gray)
        Picker(selection: $selection, label: Text("AAAA")) {
            ForEach(0 ..< pickerOptions.count) {
                Text(pickerOptions[$0])
            }
        }
        TextField("Search", text: $search).frame(width: 300, height:30).padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 0)).textFieldStyle(RoundedBorderTextFieldStyle()).help(Text("Search for files in directory"))
    }
}
