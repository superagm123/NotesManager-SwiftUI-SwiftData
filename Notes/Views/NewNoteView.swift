//
//  NewNoteView.swift
//  Notes
//
//  Created by Alfonso Gonzalez Miramontes on 03/02/25.
//

import SwiftUI
import SwiftData

struct NewNoteView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var noteTitle: String = ""
    @State private var noteBody: String = ""
    @State private var selectedColor: Color = .teal
    
    private var isFormValid: Bool {
        return !noteTitle.isEmptyOrWhitespaces && !noteBody.isEmptyOrWhitespaces
    }
    
    private func saveNote(){
        let newNote = Note(title: noteTitle.capitalized, body: noteBody, color: UIColor(selectedColor))
        context.insert(newNote)
        do{
            try context.save()
            dismiss()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        Form{
            Section("Colors"){
                ColorSelectorView(selectedColor: $selectedColor)
            }
            TextField("title", text: $noteTitle)
                .autocorrectionDisabled()
            TextField("body", text: $noteBody, axis: .vertical)
                .autocorrectionDisabled()
        }
        .navigationTitle("New Note")
        .presentationDetents([.medium])
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button(action: {
                    dismiss()
                }){
                    Image(systemName: "xmark")
                        .foregroundStyle(.red)
                        .font(.callout)
                }
            }
            ToolbarItem(placement: .topBarTrailing){
                Button("Save"){
                    saveNote()
                }
                .font(.title3)
                .foregroundStyle(isFormValid ? .green : .gray)
                .disabled(!isFormValid)
            }
        }
    }
}

#Preview {
    NavigationStack{
        NewNoteView()
            .modelContainer(for: Note.self)
    }
}
