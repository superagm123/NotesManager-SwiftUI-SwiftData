//
//  NoteDetailsView.swift
//  Notes
//
//  Created by Alfonso Gonzalez Miramontes on 03/02/25.
//

import SwiftUI

struct NoteDetailsView: View {
    
    var animation: Namespace.ID
    var note: Note
    
    @State private var animatedLayers: Bool = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: animatedLayers ? 0 : 25)
            .fill(Color(note.color).gradient)
            .matchedGeometryEffect(id: note.id, in: animation)
            .allowsHitTesting(note.allowsHitTesting)
            .onChange(of: note.allowsHitTesting, initial: true){oldValue, newValue in
                withAnimation(noteAnimation){
                    animatedLayers = newValue
                }
            }
            .overlay{
                NoteInfoView(note: note, editable: true)
            }
    }
}
