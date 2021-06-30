//
//  SlipboxAppApp.swift
//  SlipboxApp
//
//  Created by a.menshikov on 29.06.2021.
//

import SwiftUI

@main
struct SlipboxAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .frame(minWidth: 600, minHeight: 400)
//                .onAppear(perform: {
//                    UnitTestHelpers.deletesAllNotes(containter: persistenceController.container)
//                })
        }
    }
}

