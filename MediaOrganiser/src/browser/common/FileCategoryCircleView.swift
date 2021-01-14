//
//  GroupCircle.swift
//  MediaOrganiser
//
//  Created by James on 11/01/2021.
//

import SwiftUI

let groupColorDict : [EFileCategory : Color] = [EFileCategory.red : Color.red, EFileCategory.blue : Color.blue, EFileCategory.green : Color.green, EFileCategory.purple : Color.purple, EFileCategory.none : Color.gray];

struct FileCategoryCircleView: View {
    
    let fileGroup : EFileCategory
    
    var body: some View {
        Circle().fill(groupColorDict[fileGroup] ?? Color.gray).frame(width: 10, height: 10)
    }
}

struct FileGroupCircle_Previews: PreviewProvider {
    static var previews: some View {
        FileCategoryCircleView(fileGroup: EFileCategory.red)
    }
}
