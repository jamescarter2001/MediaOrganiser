//
//  BrowserItem.swift
//  MediaOrganiser
//
//  Created by James on 10/01/2021.
//

import Foundation

struct BrowserFile : Hashable, Equatable {
    
    let name : String
    let path : String
    let type : EFileType
    var group : EFileGroup
    
    init(name : String, path : String, type: EFileType, group: EFileGroup) {
        self.name = name
        self.path = path
        self.type = type
        self.group = group
    }
    init() {
        self.name = ""
        self.path = ""
        self.type = EFileType.unknown
        self.group = EFileGroup.none
    }
}
