//
//  FolderTests.swift
//  SlipboxAppTests
//
//  Created by a.menshikov on 30.06.2021.
//

import XCTest
@testable import SlipboxApp

class FolderTests: XCTestCase {
    var controller: PersistenceController!
    var context: NSManagedObjectContext {
        return controller.container.viewContext
    }

    override func setUp() {
        super.setUp()
        controller = PersistenceController.empty
    }
    
    override func tearDown() {
        super.tearDown()
        UnitTestHelpers.deleteAllFolders(container: controller.container)
    }
    
    func testAddFolder() {
        let folder = Folder(name: "new folder", context: context)
        
        XCTAssertNotNil(folder.uuid)
        XCTAssertNotNil(folder.createdAt, "folder needs to have a createdAt")
        XCTAssertTrue(folder.notes.count == 0, "created a folder with no notes")
//        let notes: [Note] = folder.notes.sorted()
    }
    
    func testAddNoteToFolder() {
        let notesTitle = "new"
        let folder = Folder(name: notesTitle, context: context)
        let note = Note(title: "add me", context: context)
        
        note.folder = folder
        
        XCTAssertTrue(note.folder?.name == notesTitle)
        XCTAssertNotNil(note.folder, "note should have been added to a folder")
        XCTAssertTrue(folder.notes.count == 1)
    }
    
    func testAddMulipleNotes() {
        let notesTitle = "new"
        let folder = Folder(name: notesTitle, context: context)

        let note1 = Note(title: "first", context: context)
        let note2 = Note(title: "first", context: context)
        
        
        folder.notes.insert(note1)
        folder.notes.insert(note2)
        
        XCTAssertTrue(note1.folder == folder)
        XCTAssertTrue(note2.folder == folder)
        XCTAssertTrue(folder.notes.count == 2)
    }
}
