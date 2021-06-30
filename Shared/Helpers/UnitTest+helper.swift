//
//  UnitTest+helper.swift
//  SlipboxApp
//
//  Created by a.menshikov on 29.06.2021.
//

import Foundation
import CoreData

struct UnitTestHelpers {
    static func deletesAllNotes(container: NSPersistentCloudKitContainer) {
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        _ = try? container.persistentStoreCoordinator.execute(deleteRequest, with: context)
    }
    
    static func deleteAllFolders(container: NSPersistentCloudKitContainer) {
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Folder")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        _ = try? container.persistentStoreCoordinator.execute(deleteRequest, with: context)
    }
}
