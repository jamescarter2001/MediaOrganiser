//
//  BrowserItem.swift
//  MediaOrganiser
//
//  Created by James on 11/01/2021.
//

import Foundation

struct BrowserFile : Hashable, Equatable, Codable {
    
    let name : String
    let path : String
    let type : EFileType
    let size : UInt64
    var comment : String
    
    init(name: String, path: String, size: UInt64, type: EFileType, comment : String) {
        self.name = name
        self.path = path
        self.type = type
        self.size = size
        self.comment = comment
    }
    init() {
        self.name = ""
        self.path = ""
        self.size = 0
        self.type = EFileType.unknown
        self.comment = ""
    }
}
