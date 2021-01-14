//
//  JSONCoder.swift
//  MediaOrganiser
//
//  Created by James on 13/01/2021.
//

import Foundation

class JSONBrowserFileHandler {
    
    static let encoder = JSONEncoder()
    
    static func EncodeAndSaveFile(dict : [String:[BrowserFile]], path : String) {
        
        var encodedString : String = ""
        
        do {
            let encoded : Data = try encoder.encode(dict)
            encodedString = String(data: encoded, encoding: .utf8)!
        } catch {
            print("Encode error: \(error)")
        }
        
        var pathUrl = URLComponents()
        pathUrl.scheme = "file"
        pathUrl.path = path
        
        do {
            try encodedString.write(to: pathUrl.url!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("File write error: \(error)")
        }
    }
    
    static func DecodeFile(path : String) -> [String:[BrowserFile]] {
        
        var finalDict : [String : [BrowserFile]] = [:]
        
        let encodedPath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let pathUrl = URL(string: encodedPath!)!
        var testUrl = URLComponents()
        testUrl.scheme = "file"
        testUrl.path = path
        
        do {
            
            let data = try String(contentsOf: testUrl.url!).data(using: .utf8)!
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                
                    for key in Array(json.keys) {
                        
                        let block = json[key] as! [[String:Any]]
                        var files : [BrowserFile] = []
                        
                        for file in block {
                            let browserFile : BrowserFile = BrowserFile(name: file["name"] as! String, path: file["path"] as! String, size: file["size"] as! UInt64, type: EFileType(rawValue: file["type"] as! String) ?? EFileType.unknown, comment: file["comment"] as! String)
                            
                            files.append(browserFile)
                        }
                        finalDict[key] = files
                    }
            }
        } catch {
            print("Decode error: \(error)")
        }
        print(finalDict)
        return finalDict
    }
}
