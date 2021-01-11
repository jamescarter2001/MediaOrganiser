//
//  BrowserItem.swift
//  MediaOrganiser
//
//  Created by James on 10/01/2021.
//

import Foundation

class BrowserFile : Identifiable {
    let id = UUID()
    let name : String
    let path : String
    let size : UInt64
    let type : EFileType
    let group : EFileGroup
    
    init(name : String, path : String, size : UInt64, type: EFileType, group: EFileGroup) {
        self.name = name
        self.path = path
        self.size = size
        self.type = type
        self.group = group
    }
    init() {
        self.name = ""
        self.path = ""
        self.size = 0
        self.type = EFileType.mp3
        self.group = EFileGroup.red
    }
}
