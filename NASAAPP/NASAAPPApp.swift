//
//  NASAAPPApp.swift
//  NASAAPP
//
//  Created by SRIKANTH S on 18/01/23.
//

import SwiftUI

@main
struct NASAAPPApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
