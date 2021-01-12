//
//  WelcomeView.swift
//  MediaOrganiser
//
//  Created by James on 11/01/2021.
//

import SwiftUI

let data : [String] = ["AAA", "BBB"]

struct WelcomeView: View {
    
    let message : String
    @State var selectKeeper = Set<String>()

   var body: some View {
    List(data, id: \.self, selection: $selectKeeper) { item in
        HStack(alignment: .center) {
            Text(item)
        }
    }.listStyle(SidebarListStyle())
   }
}

struct TextView: View {

   var body: some View {
    HSplitView {
    Text("AAAA")
    Text("AAAA")
    }
   }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}
