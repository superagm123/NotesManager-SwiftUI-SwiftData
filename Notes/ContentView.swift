//
//  ContentView.swift
//  Notes
//
//  Created by Alfonso Gonzalez Miramontes on 03/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeScreen()
    }
}

#Preview{
    ContentView()
        .modelContainer(for: Note.self)
}
