//
//  TopBar.swift
//  Notes
//
//  Created by Alfonso Gonzalez Miramontes on 03/02/25.
//

import SwiftUI

struct TopBar: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var isDeleteAlertPresented: Bool = false
    @State private var selectedColor: Color = .teal
    @Binding var selectedNote: Note?
    
    var body: some View {
        VStack{
            Text("AGM-Notes")
                .font(.title2.bold())
                .foregroundStyle(.green.gradient)
                .opacity(selectedNote != nil ? 0 : 1)
            if selectedNote != nil {
                HStack(spacing: 15){
                    Button{
                        withAnimation{
                            selectedNote = nil
                        }
                    }label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .foregroundStyle(.red)
                    }
                    ColorSelectorView(selectedColor: $selectedColor)
                }
                .padding()
            }
        }
        .animation(noteAnimation, value: selectedNote != nil)
        .onChange(of: selectedNote){
            guard let selectedNote else { return }
            selectedColor = selectedNote.color.suColor
        }
        .onChange(of: selectedColor){
            selectedNote?.color = UIColor(selectedColor)
            do{
                try context.save()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

#Preview{
    TopBar(selectedNote: .constant(nil))
}
