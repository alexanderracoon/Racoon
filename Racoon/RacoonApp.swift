//
//  RacoonApp.swift
//  Racoon
//
//  Created by Александр Переславцев on 28.03.2026.
//

import SwiftUI
import CoreData

@main
struct RacoonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
