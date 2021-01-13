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
    let size : UInt64
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
                Text("\(size / (1024)) KB").foregroundColor(.gray)
                Text(type.rawValue.uppercased()).foregroundColor(.gray).frame(width: 40, height: 8,alignment: .trailing)
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
        BrowserItemView(name: "AAAA",path:"/Users/james/Documents", size:10, type: EFileType.mp3, group: EFileGroup.red)
    }
}
