//
//  BrowserListItem.swift
//  MediaOrganiser
//
//  Created by James on 10/01/2021.
//

import SwiftUI

struct BrowserItemView: View {
    
    let name : String
    let path : String
    let type : EFileType
    let group : EFileGroup
    
    var body: some View {
        HStack {
            FileGroupCircleView(fileGroup: group)
            VStack(alignment: .leading) {
                Text(name)
                Text(path).foregroundColor(.gray).font(.subheadline)
            }
            Spacer()
            HStack {
                Text(type.rawValue.uppercased()).foregroundColor(.gray)
                /*
                Button(action: {
                    
                }) {
                    Image(systemName: "plus.app.fill").resizable().foregroundColor(.blue).frame(width: 30, height: 30, alignment: .center)
                }.buttonStyle(PlainButtonStyle())*/
            }
        }
    }
}

struct BrowserListItem_Previews: PreviewProvider {
    static var previews: some View {
        BrowserItemView(name: "AAAA",path:"/Users/james/Documents" , type: EFileType.mp3, group: EFileGroup.red)
    }
}
