//
//  MediaOrganiserApp.swift
//  MediaOrganiser
//
//  Created by James on 09/01/2021.
//

import SwiftUI

@main
struct MediaOrganiserApp: App {
    var body: some Scene {
        WindowGroup {
            //WelcomeView(message: "AAAA")
            //TextView()
            ContentView().environmentObject(UserData())
        }
    }
}
