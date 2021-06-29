//
//  NoteRow.swift
//  SlipboxApp
//
//  Created by a.menshikov on 29.06.2021.
//

import SwiftUI

struct NoteRow: View {
    let title: String
    let bodyText: String
    let createdAt: Date
    let isSelected: Bool
    
    let selectedColor: Color = Color("selectedColor")
    let unSelectedColor: Color = Color("unselectedColor")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            HStack {
                Text(title)
                Spacer()
                Text(createdAt, formatter: itemFormatter)
            }
            
            Text(bodyText)
                .lineLimit(2)
                .font(.caption)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(isSelected ? selectedColor : unSelectedColor)
        )
        .padding(.bottom)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 5.0) {
            NoteRow(title: "Title", bodyText: "body text", createdAt: Date(), isSelected: false)
            NoteRow(title: "Title", bodyText: "body text", createdAt: Date(), isSelected: true)
        }
        .padding()
        .frame(width: 250)
    }
}
