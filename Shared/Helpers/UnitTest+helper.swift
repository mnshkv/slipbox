//
//  UnitTest+helper.swift
//  SlipboxApp
//
//  Created by a.menshikov on 29.06.2021.
//

import Foundation
import CoreData

struct UnitTestHelpers {
    static func deletesAllNotes(containter: NSPersistentCloudKitContainer) {
        let context = containter.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        try? containter.persistentStoreCoordinator.execute(deleteRequest, with: context)
    }
}
