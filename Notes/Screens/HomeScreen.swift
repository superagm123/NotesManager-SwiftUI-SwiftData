//
//  HomeScreen.swift
//  Notes
//
//  Created by Alfonso Gonzalez Miramontes on 03/02/25.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {
    
    @Environment(\.modelContext) private var context
    
    @Query(sort: \Note.title, order: .forward) private var notes: [Note]
    
    @State private var searchText: String = ""
    @State private var isNewNoteSheetPresented: Bool = false
    @State private var isDeleteNoteAlertPresented: Bool = false
    @State private var selectedNote: Note?
    @State private var isAnimated: Bool = false
    @Namespace private var animation
    
    private var columns: [GridItem] = Array(repeating: GridItem(), count: 2)
    
    private func deleteNote(){
        guard let selectedNote else { return }
        context.delete(selectedNote)
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        ScrollView(.vertical){
            VStack(spacing: 20){
                SearchBar(searchText: $searchText)
                if !notes.isEmpty{
                    LazyVGrid(columns: columns){
                        ForEach(notes.filter{
                            searchText.isEmpty ? true : $0.title.contains(searchText) || $0.body.contains(searchText.lowercased())
                        }){note in
                            NoteView(note)
                                .frame(height: 200)
                                .onTapGesture{
                                    guard selectedNote == nil else { return }
                                    selectedNote = note
                                    note.allowsHitTesting = true
                                    withAnimation(noteAnimation){
                                        isAnimated = true
                                    }
                                }
                        }
                    }
                }else{
                    ContentUnavailableView("No notes yet.", systemImage: "list.clipboard")
                }
            }
        }
        .safeAreaPadding(15)
        .overlay{
            GeometryReader{_ in
                ForEach(notes){note in
                    if selectedNote?.id == note.id && isAnimated {
                        NoteDetailsView(animation: animation, note: note)
                            .ignoresSafeArea(.container, edges: .bottom)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .sheet(isPresented: $isNewNoteSheetPresented){
            NavigationStack{
                NewNoteView()
            }
        }
        .overlay(alignment: .bottomTrailing){
            FloatingActionButton(icon: selectedNote != nil ? "trash" : "plus", color: selectedNote != nil ? .red : .green){
                if selectedNote != nil {
                    isDeleteNoteAlertPresented = true
                }else{
                    isNewNoteSheetPresented = true
                }
            }
            .contentTransition(.symbolEffect(.replace))
            .alert("Are you sure to delete this note?", isPresented: $isDeleteNoteAlertPresented){
                Button("No"){}
                Button("Yes"){
                    withAnimation(noteAnimation){
                        deleteNote()
                        selectedNote = nil
                        isAnimated = false
                    }
                }
            }
        }
        .safeAreaInset(edge: .top, spacing: 0){
            TopBar(selectedNote: $selectedNote)
        }
    }
    
    @ViewBuilder
    func NoteView(_ note: Note) -> some View {
        ZStack{
            if selectedNote?.id == note.id && isAnimated{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(note.color).gradient)
            }else{
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(note.color).gradient)
                    .matchedGeometryEffect(id: note.id, in: animation)
            }
            NoteInfoView(note: note, editable: false)
        }
    }
}

#Preview {
    HomeScreen()
        .modelContainer(for: Note.self)
}
