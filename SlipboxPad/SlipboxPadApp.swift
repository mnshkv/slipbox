//
//  SlipboxPadApp.swift
//  SlipboxPad
//
//  Created by a.menshikov on 29.06.2021.
//

import SwiftUI

@main
struct SlipboxPadApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
