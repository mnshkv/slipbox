//
//  NotesTests.swift
//  SlipboxAppTests
//
//  Created by a.menshikov on 29.06.2021.
//

import XCTest
@testable import SlipboxApp

class NotesTests: XCTestCase {
    var controller: PersistenceController!
    
    override func setUp() {
        super.setUp()
        controller = PersistenceController.empty
    }
    
    override func tearDown() {
        super.tearDown()
        UnitTestHelpers.deletesAllNotes(containter: controller.container)
    }
    
    func testAddNotes() {
        let context = controller.container.viewContext
        let title = "new"
        let note = Note(title: title, context: context)
        
        XCTAssertTrue(note.title == title)
        XCTAssertNotNil(note.createdAt, "not should have a date")
    }
    
    func testUpdateNote() {
        let context = controller.container.viewContext
        let note = Note(title: "old", context: context)
        note.title = "new"
        
        XCTAssertTrue(note.title == "new")
        XCTAssertFalse(note.title == "old", "note's title not correctly updated")
    }
    
    func testFetchNotes() {
        let context = controller.container.viewContext
        let note = Note(title: "fetch me", context: context)
        let request = Note.fetch(NSPredicate.all)
        
        let fechtedNotes = try? context.fetch(request)
        
        XCTAssertTrue(fechtedNotes!.count == 1, "need to have at least one note")
        XCTAssertTrue(fechtedNotes?.first == note, "new note should be fetched")
    }
    
    func testSave() {
        expectation(forNotification: .NSManagedObjectContextDidSave, object: controller.container.viewContext) { _ in
            return true
        }
        
        controller.container.viewContext.perform {
            let note = Note(title: "title", context: self.controller.container.viewContext)
            XCTAssertNotNil(note, "note should be there")
        }
        
        waitForExpectations(timeout: 2.0) { (error) in
            XCTAssertNil(error, "saving not complete")
        }
    }
    
    func testDeleteNote() {
        let context = controller.container.viewContext
        let note = Note(title: "note to delete", context: context)
        
        Note.delete(note: note)
        
        let request = Note.fetch(.all)
        let fetchedNotes = try? context.fetch(request)
        
        XCTAssertTrue(fetchedNotes!.count == 0, "core data fetch should be empty")
        XCTAssertFalse(fetchedNotes!.contains(note), "fetch notes should not containe my deleted note")
    }
}
