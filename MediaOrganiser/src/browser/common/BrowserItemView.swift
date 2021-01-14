//
//  BrowserListItem.swift
//  MediaOrganiser
//
//  Created by James on 11/01/2021.
//

import SwiftUI

struct BrowserItemView: View {
    
    let name : String
    let path : String
    let size : UInt64
    let type : EFileType
    let comment : String
    let category : EFileCategory?
    var imagePath : String = ""
    
    var body: some View {
        HStack {
            ImageView(path: imagePath)
            VStack(alignment: .leading) {
                Text(name)
                Text(path).foregroundColor(.gray).font(.subheadline)
            }
            Spacer()
            Text(comment).foregroundColor(.gray).multilineTextAlignment(.center)
            HStack {
                Text("\(size / (1024)) KB").foregroundColor(.gray)
                Text(type.rawValue.uppercased()).foregroundColor(.gray).frame(width: 40, height: 8,alignment: .trailing)
            }
        }
    }
}

struct ImageView : View {
    let path : String
    var body : some View {
        if (!path.isEmpty) {
            Image(nsImage: NSImage(contentsOfFile: path)!).resizable().frame(width: 40, height: 40)
        } else {
            ZStack {
                Rectangle().frame(width: 40, height: 40).foregroundColor(Color( red: 1, green: 1, blue: 1, opacity: 0.1)).cornerRadius(3.0)
                Image(systemName: "questionmark").frame(width: 40, height: 40)
            }
        }
    }
}

struct BrowserListItem_Previews: PreviewProvider {
    static var previews: some View {
        BrowserItemView(name: "AAAA",path:"/Users/james/Documents", size:10, type: EFileType.mp3, comment: "Test comment", category: EFileCategory.none)
    }
}
