//
//  GroupManagerService.swift
//  MediaOrganiser
//
//  Created by James on 12/01/2021.
//

import Foundation

class GroupManagerService {

@Published private var fileGroupMembers : [BrowserFile]

    init() {
        self.fileGroupMembers = []
        }
    
    func addToGroup(files: Set<BrowserFile>, group : EFileGroup) {
        
        do {
            
            files.forEach { file in
        if (!fileGroupMembers.contains(file)) {
            fileGroupMembers.append(file)
            #if DEBUG
            print("Added item \(file.path) to group: \(group.rawValue)")
            #endif
        } else {
            #if DEBUG
            print("Error: file already exists in group.")
            #endif
                }
            }
        }
    }
    
    func getFilesInGroup(group : EFileGroup) -> [BrowserFile] {
        return fileGroupMembers.filter {$0.group == group}
    }
    
    /*func getGroups(files : [BrowserFile]) -> [BrowserFile] {
        
        files.forEach { item in
            fileGroupMembers.forEach { groupMember in
                if groupMember.path == 
            }
        }
        
        return
    }*/
    
    /*init(path:String) {
        let encodedPath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let pathUrl = URL(string: encodedPath!)!
        var files : [BrowserFile] = []
        
        
    }*/
}
