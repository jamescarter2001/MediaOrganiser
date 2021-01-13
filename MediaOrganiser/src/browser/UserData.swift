//
//  UserData.swift
//  MediaOrganiser
//
//  Created by James on 12/01/2021.
//

import Foundation
import SwiftUI
import Combine

class UserData : ObservableObject {
    var didChange = PassthroughSubject<UserData, Never>()
    
    var data : [BrowserFile] = [] {
        didSet {
            didChange.send(self)
        }
    }
}
