//
//  Note+helper.swift
//  SlipboxApp
//
//  Created by a.menshikov on 29.06.2021.
//

import Foundation
import CoreData

extension Note {
    convenience init(title: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.createdAt = Date()
        
        try? context.save()
    }
    
    override public func awakeFromInsert() {
        setPrimitiveValue(Date(), forKey: NoteProperties.createdAt)
        setPrimitiveValue(UUID(), forKey: NoteProperties.uuid)
    }
    
    var title: String {
        get { return title_ ?? "" }
        set { title_ = newValue }
    }
    
    var createdAt: Date {
        get { return createdAt_ ?? Date() }
        set { createdAt_ = newValue }
    }
    
    var bodyText: String {
        get { return bodyText_ ?? "" }
        set { bodyText_ = newValue }
    }
    
    var uuid: UUID {
        get { return uuid_ ?? UUID() }
        set { uuid_ = newValue }
    }
    
//    var status: String {
//        get { return status_ ?? "" }
//    }
    
    static func fetch(_ predicate: NSPredicate) -> NSFetchRequest<Note> {
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.sortDescriptors = [NSSortDescriptor(key: NoteProperties.createdAt, ascending: false)]
        
        request.predicate = predicate
        
        return request
    }
    
    static func delete(note: Note) {
        if let context = note.managedObjectContext {
            context.delete(note)
        }
    }
}

// MARK: - propery names as strings

struct  NoteProperties {
    static let createdAt = "createdAt_"
    static let title = "title_"
    static let uuid = "uuid_"
    static let status = "status_"
    static let img = "img_"
    static let bodyText = "bodyText_"
}
