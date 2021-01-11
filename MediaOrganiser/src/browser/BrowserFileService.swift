//
//  FileProvider.swift
//  MediaOrganiser
//
//  Created by James on 10/01/2021.
//

import Foundation

class BrowserFileService {
    
    func getForPath(path : String) -> [BrowserFile] {
        
        // Prevent crashes with spaced folder names.
        let encodedPath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let pathUrl = URL(string: encodedPath!)!
        var files : [BrowserFile] = []
        
        do {
            let pathContents = try FileManager.default.contentsOfDirectory(at: pathUrl, includingPropertiesForKeys: nil)
            print(pathContents)
            for item in pathContents {
                let attr = try FileManager.default.attributesOfItem(atPath: item.path)
                let fileType = EFileType(rawValue: item.pathExtension) ?? EFileType.unknown
                
                if (fileType != EFileType.unknown) {
                let file : BrowserFile = BrowserFile(name: item.lastPathComponent, path: item.path, size: attr[FileAttributeKey.size] as! UInt64, type: fileType, group: EFileGroup.none)
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
