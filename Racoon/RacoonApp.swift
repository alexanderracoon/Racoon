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
//    let persistenceController = PersistenceController.shared
//    @StateObject var viewModel = ViewModel()
//    @State private var paybackViewModel = PlaybackManager()
    private var viewModel = ViewModel()
    private var playbackManager = PlaybackManager()
    
    var body: some Scene {
        WindowGroup {
            HomeScreenView()
                .environment(viewModel)
                .environment(playbackManager)
        
            
            //MARK: - Заменить на CoreDataStack
//.environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
    }
}
