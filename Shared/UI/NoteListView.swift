//
//  NoteListView.swift
//  SlipboxApp
//
//  Created by a.menshikov on 29.06.2021.
//

import SwiftUI

struct NoteListView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(fetchRequest: Note.fetch(NSPredicate.all)) private var notes: FetchedResults<Note>
    
    @Binding var selectedNote: Note?
        
    var body: some View {
        VStack {
            HStack {
                Text("Notes").font(.title)
                Spacer()
                Button(action: {
                    _ = Note(title: "new note", context: context)
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .padding(.all)
            List {
                ForEach(notes) { note in
                    NoteRow(title: note.title, bodyText: note.bodyText, createdAt: note.createdAt, isSelected: selectedNote == note)
                        .onTapGesture {
                            selectedNote = note
                        }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let request = Note.fetch(NSPredicate.all)
        let fechtedNotes = try? context.fetch(request)
        
        return NoteListView(selectedNote: .constant(fechtedNotes?.first))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
