//
//  JSONCoder.swift
//  MediaOrganiser
//
//  Created by James on 13/01/2021.
//

import Foundation

class JSONFileHandler<T : Codable> {
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func encodeAndSaveFile(array : [T], path : String) {
        
        var encodedString : String = ""
        
            do {
            let encoded : Data = try encoder.encode(array)
            encodedString = String(data: encoded, encoding: .utf8)!
            } catch {
                print("Error encoding array: \(array)")
            }
        
        let filename = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("/Desktop/output.wzstate")

        do {
            try encodedString.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("File write error!")
        }

        print(encodedString)
    }
    
    func decodeFile(path : String) {
        let encodedPath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let pathUrl = URL(string: encodedPath!)!
        
        let json = """
        {
            "name": "Durian",
            "points": 600,
            "description": "A fruit with a distinctive scent."
        }
        """.data(using: .utf8)!
        
        do {
            
            
            
            let array : [T] = try decoder.decode([T].self, from: json)
        } catch {
            print("Decode error!")
        }
    }
}
