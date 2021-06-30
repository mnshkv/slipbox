//
//  NoteView.swift
//  SlipboxApp
//
//  Created by a.menshikov on 29.06.2021.
//

import SwiftUI

struct NoteView: View {
    @ObservedObject var note: Note
    
    @State private var isDropTargeted: Bool = false
    
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
            
            if note.img != nil {
                Image(nsImage: NSImage(data: note.img!) ?? NSImage())
                    .resizable()
                    .scaledToFit()
                    .contextMenu(ContextMenu(menuItems: {
                        Button(action: {
                            note.img = nil
                        }, label: {
                            Text("remove image")
                        })
                    }))
            }
                        
            Text("Keywords: ")
            Text("linked Notes: ")
        }
        .padding()
        .background(isDropTargeted ? Color.gray : Color.clear)
        .onDrop(of: ["public.file-url"], isTargeted: $isDropTargeted, perform: { providers in
            handleDrop(providers: providers)
        })
    }
    
    func handleDrop(providers: [NSItemProvider]) -> Bool {
        let found = providers.loadObjects(ofType: URL.self) { item in
            if let image = NSImage(contentsOf: item.absoluteURL) {
                let data = image.tiffRepresentation
                note.img = data
                if let context = note.managedObjectContext {
                    try? context.save()
                }
            }
        }

        return found
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: Note(context: PersistenceController.preview.container.viewContext))
    }
}
