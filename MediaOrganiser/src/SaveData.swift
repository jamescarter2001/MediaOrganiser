//
//  UserData.swift
//  MediaOrganiser
//
//  Created by James on 12/01/2021.
//

import Foundation
import SwiftUI
import Combine

class SaveData : ObservableObject {
    var didChange = PassthroughSubject<SaveData, Never>()
    
    // Initiliise save data dictionary with standard categories
    var groupData : [String:[MediaFile]] = [EFileCategory.red.rawValue:[],EFileCategory.blue.rawValue:[], EFileCategory.green.rawValue:[], EFileCategory.purple.rawValue:[]] {
        didSet {
            didChange.send(self)
        }
    }
}
