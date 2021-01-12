//
//  GroupCircle.swift
//  MediaOrganiser
//
//  Created by James on 10/01/2021.
//

import SwiftUI

let groupColorDict : [EFileGroup:Color] = [EFileGroup.red:Color.red, EFileGroup.blue:Color.blue, EFileGroup.green:Color.green, EFileGroup.purple:Color.purple,
    EFileGroup.none:Color.gray];

struct FileGroupCircleView: View {
    
    let fileGroup : EFileGroup
    
    var body: some View {
        Circle().fill(groupColorDict[fileGroup] ?? Color.gray).frame(width: 10, height: 10)
    }
}

struct FileGroupCircle_Previews: PreviewProvider {
    static var previews: some View {
        FileGroupCircleView(fileGroup: EFileGroup.red)
    }
}
