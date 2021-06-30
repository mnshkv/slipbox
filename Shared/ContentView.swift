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
                NoteListView(selectedNote: $selectedNote)
            }
        #else
            HSplitView {
                NoteListView(selectedNote: $selectedNote)
                    .frame(minWidth: 100, idealWidth: 150, maxWidth: 300)
                    
                
                if selectedNote != nil {
                    NoteView(note: selectedNote!)
                } else {
                    VStack {
                        Spacer()
                        Text("please select a note")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
