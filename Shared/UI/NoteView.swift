//
//  NoteView.swift
//  SlipboxApp
//
//  Created by a.menshikov on 29.06.2021.
//

import SwiftUI

struct NoteView: View {
    @ObservedObject var note: Note
    
    var body: some View {
        VStack(spacing: 0.0) {
            TextField("Notes title", text: $note.title)
            TextEditor(text: $note.bodyText)
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: Note(context: PersistenceController.preview.container.viewContext))
    }
}
