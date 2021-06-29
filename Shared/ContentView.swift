//
//  ContentView.swift
//  SlipboxApp
//
//  Created by a.menshikov on 29.06.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedNote: Note? = nil
    
    var body: some View {
        #if os(iOS)
            VStack {
                NoteListView()
            }
        #else
            HSplitView {
                NoteListView(selectedNote: $selectedNote)
                if selectedNote != nil {
                    NoteView(note: selectedNote!)
                } else {
                    VStack {
                        Spacer()
                        Text("please select a note")
                        Spacer()
                    }
                }
            }
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
