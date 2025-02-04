//
//  NotesApp.swift
//  Notes
//
//  Created by Alfonso Gonzalez Miramontes on 03/02/25.
//

import SwiftUI
import SwiftData

@main
struct NotesApp: App {
    
    init(){
        ValueTransformer.setValueTransformer(UIColorValueTransformer(), forName: NSValueTransformerName("UIColorValueTransformer"))
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Note.self)
        }
    }
}
