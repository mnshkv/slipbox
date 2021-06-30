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
    @State private var shouldDeleteNote: Note? = nil
        
    var body: some View {
        VStack {
            HStack {
                Text("Notes").font(.title)
                Spacer()
                Button(action: {
                    let note = Note(title: "new note", context: context)
                    selectedNote = note
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
                        .contextMenu(ContextMenu(menuItems: {
                            Button(action: {
                                shouldDeleteNote = note
                            }, label: {
                                Text("delete")
                            })
                        }))
                        .padding(.bottom)
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
        .alert(item: $shouldDeleteNote) { noteToDelete in
            deleteAlert(note: noteToDelete)
        }
    }
    
    func deleteAlert(note: Note) -> Alert {
        Alert(title: Text("Are you sure to delete this note?"), message: nil, primaryButton: Alert.Button.cancel(), secondaryButton: Alert.Button.destructive(Text("Detele"), action: {
            if selectedNote == note {
                selectedNote = nil
            }
            Note.delete(note: note)
        }))
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
