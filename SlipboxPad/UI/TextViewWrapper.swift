//
//  TextViewWrapper.swift
//  SlipboxPad
//
//  Created by a.menshikov on 30.06.2021.
//

import SwiftUI

struct TextViewWrapper: UIViewRepresentable {
    let note: Note
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, note: note)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let uiview = UITextView()
        
        uiview.isEditable = true
        uiview.isSelectable = true
        
        return uiview
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.textStorage.setAttributedString(note.formattedText)
        context.coordinator.note = note
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextViewWrapper
        var note: Note
        
        init(_ parent: TextViewWrapper, note: Note) {
            self.parent = parent
            self.note = note
        }
        
        func textViewDidChange(_ textView: UITextView) {
            note.formattedText = textView.attributedText
        }
    }
}

//struct TextViewWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        TextViewWrapper()
//    }
//}
