//
//  JSONCoder.swift
//  MediaOrganiser
//
//  Created by James on 13/01/2021.
//

import Foundation

class JSONmediaFileHandler {
    
    static let encoder = JSONEncoder()
    
    static func EncodeAndSaveFile(dict : [String:[MediaFile]], path : String) {
        
        var encodedString : String = ""
        
        do {
            let encoded : Data = try encoder.encode(dict)
            encodedString = String(data: encoded, encoding: .utf8)!
        } catch {
            print("Encode Error: \(error)")
        }
        
        var pathUrl = URLComponents()
        pathUrl.scheme = "file"
        pathUrl.path = path
        
        do {
            try encodedString.write(to: pathUrl.url!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("File Write Error: \(error)")
        }
    }
    
    static func DecodeFile(path : String) -> [String:[MediaFile]] {
        
        var finalDict : [String : [MediaFile]] = [:]

        var fileUrl = URLComponents()
        fileUrl.scheme = "file"
        fileUrl.path = path
        
        do {
            
            let data = try String(contentsOf: fileUrl.url!).data(using: .utf8)!
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                
                    for group in Array(json.keys) {
                        
                        let jsonFileGroup = json[group] as! [[String:Any]]
                        var files : [MediaFile] = []
                        
                        for file in jsonFileGroup {
                            let mediaFile : MediaFile = MediaFile(name: file["name"] as! String, path: file["path"] as! String, type: EFileType(rawValue: file["type"] as! String) ?? EFileType.unknown, size: file["size"] as! UInt64,imagePath: file["imagePath"] as! String, comment: file["comment"] as! String)
                            
                            files.append(mediaFile)
                        }
                        finalDict[group] = files
                    }
            }
        } catch {
            print("Decode Error: \(error)")
        }
        print(finalDict)
        return finalDict
    }
}
