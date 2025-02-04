//
//  NoteInfoView.swift
//  Notes
//
//  Created by Alfonso Gonzalez Miramontes on 03/02/25.
//

import SwiftUI
import SwiftData

struct NoteInfoView: View {
    
    @Environment(\.modelContext) private var context
    
    let note: Note
    
    var editable: Bool
    
    private func saveChanges(){
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            if editable{
                TextField(note.title, text: Binding(get: {
                    note.title
                }, set: {newValue in
                    note.title = newValue
                    saveChanges()
                }))
                .autocorrectionDisabled()
                RoundedRectangle(cornerRadius: 0)
                    .frame(height: 1)
                TextField(note.body, text: Binding(get: {
                    note.body
                }, set: {newValue in
                    note.body = newValue
                    saveChanges()
                }), axis: .vertical)
                .autocorrectionDisabled()
            }else{
                Text(note.title)
                    .font(.title2.bold())
                RoundedRectangle(cornerRadius: 0)
                    .frame(height: 1)
                Text(note.body)
                    .font(.title3)
            }
            Spacer(minLength: 0)
            RoundedRectangle(cornerRadius: 0)
                .frame(height: 1)
            Text(note.date.formatted(.dateTime))
                .font(.callout)
                .fontWeight(.semibold)
        }
        .foregroundStyle(.white)
        .padding()
    }
}

struct NoteInfoViewContainer: View {
    
    @Query private var notes: [Note]
    
    var body: some View {
        NoteInfoView(note: notes.first!, editable: false)
    }
}

#Preview{
    NoteInfoViewContainer()
        .modelContainer(for: Note.self)
}
