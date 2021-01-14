//
//  EFileType.swift
//  MediaOrganiser
//
//  Created by James on 11/01/2021.
//

import Foundation

// Supported file type as specified by requirements.
enum EFileType : String, CaseIterable, Codable {
    case mp3, aac, wav, avi, m4a, flac, mp4, mkv, unknown
}
