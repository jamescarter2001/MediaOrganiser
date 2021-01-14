//
//  FileProvider.swift
//  MediaOrganiser
//
//  Created by James on 11/01/2021.
//

import Foundation

class SystemBrowserFileService {
    
    func getForPath(path : String, groupData : [String:[BrowserFile]]) -> [BrowserFile] {
        
        // Prevent crashes with spaced folder names.
        let encodedPath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let pathUrl = URL(string: encodedPath!)!
        
        var files : [BrowserFile] = []
        
        do {
            let pathContents = try FileManager.default.contentsOfDirectory(at: pathUrl, includingPropertiesForKeys: nil)
            for file in pathContents {
                let attr = try FileManager.default.attributesOfItem(atPath: file.path)
                let fileType = EFileType(rawValue: file.pathExtension) ?? EFileType.unknown
                
                // Filter out irrelevant files.
                if (fileType != EFileType.unknown) {
                    var file : BrowserFile = BrowserFile(name: file.lastPathComponent, path: file.path, type: fileType, size: attr[FileAttributeKey.size] as! UInt64, imagePath: "", comment:"")
                    
                    let groups = Array(groupData.keys)
                    
                    for group in groups {
                        let members = groupData[group]
                        
                        // Fetch file comments from cache.
                        members!.forEach { i in
                            if (i.path == file.path) {
                                file.comment = i.comment
                                file.imagePath = i.imagePath
                            }
                        }
                    }
                files.append(file)
                }
            }
            return files
            
        } catch {
            print("System Directory Read Error (\(path): \(error)")
        }
        return []
    }
}
