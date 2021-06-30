//
//  Folder+helper.swift
//  SlipboxApp
//
//  Created by a.menshikov on 30.06.2021.
//

import Foundation
import CoreData

extension Folder {
    convenience init(name: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.createdAt = Date()
    }
    
    var uuid: UUID {
        get { return uuid_ ?? UUID() }
        set { uuid_ = newValue }
    }
    
    var createdAt: Date {
        get { return createdAt_ ?? Date() }
        set { createdAt_ = newValue }
    }
    
    var name: String {
        get { return name_ ?? "" }
        set{ name_ = newValue }
    }
    
    var notes: Set<Note> {
        get { notes_ as? Set<Note> ?? [] }
        set { notes_ = newValue as NSSet }
    }
    
    // TODO: fetch request
    
    // TODO: delete
    
}


// TODO: define my string properties
