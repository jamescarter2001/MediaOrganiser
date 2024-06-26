//
//  BrowserItem.swift
//  MediaOrganiser
//
//  Created by James on 11/01/2021.
//

import Foundation

struct MediaFile : Hashable, Equatable, Codable {
    
    let name : String
    let path : String
    let type : EFileType
    let size : UInt64
    var imagePath : String
    var comment : String
    
    init(name: String, path: String, type: EFileType, size: UInt64, imagePath : String, comment : String) {
        self.name = name
        self.path = path
        self.type = type
        self.size = size
        self.imagePath = imagePath
        self.comment = comment
    }
    init() {
        self.name = ""
        self.path = ""
        self.size = 0
        self.imagePath = ""
        self.type = EFileType.unknown
        self.comment = ""
    }
}
