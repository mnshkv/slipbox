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
        VStack(alignment: .leading, spacing: 10.0) {
            Picker(selection: $note.status, label: Text("Status"), content: {
                ForEach(Status.allCases, id: \.self) { status in
                    Text(status.rawValue)
                }
            })
            .pickerStyle(SegmentedPickerStyle())
            .frame(maxWidth: 250)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            TextField("Notes title", text: $note.title)
                .font(.title)
                .textFieldStyle(PlainTextFieldStyle())
            
            TextViewWrapper(note: note)
                        
            Text("Keywords: ")
            Text("linked Notes: ")
        }
        .padding()
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: Note(context: PersistenceController.preview.container.viewContext))
    }
}
