//
//  FileProvider.swift
//  MediaOrganiser
//
//  Created by James on 11/01/2021.
//

import Foundation

class SystemBrowserFileService {
    
    func getForPath(path : String, groupMembers : [String:[BrowserFile]]) -> [BrowserFile] {
        
        // Prevent crashes with spaced folder names.
        let encodedPath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let pathUrl = URL(string: encodedPath!)!
        var files : [BrowserFile] = []
        
        do {
            let pathContents = try FileManager.default.contentsOfDirectory(at: pathUrl, includingPropertiesForKeys: nil)
            for item in pathContents {
                let attr = try FileManager.default.attributesOfItem(atPath: item.path)
                let fileType = EFileType(rawValue: item.pathExtension) ?? EFileType.unknown
                
                if (fileType != EFileType.unknown) {
                    var file : BrowserFile = BrowserFile(name: item.lastPathComponent, path: item.path, size: attr[FileAttributeKey.size] as! UInt64, type: fileType, comment:"")
                    
                    let keys = Array(groupMembers.keys)
                    
                    for key in keys {
                        let members = groupMembers[key]
                        
                        members!.forEach { i in
                            if (i.path == file.path) {
                                file.comment = i.comment
                            }
                        }
                        
                    }
                    
                    
                files.append(file)
                }
            }
            return files
            
        } catch {
            print("error")
        }
        return [BrowserFile()]
    }
}
