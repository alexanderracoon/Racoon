//
//  CoreDataManager.swift
//  Racoon
//
//  Created by Александр Переславцев on 07.04.2026.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
//    private init() {}
        
    let container: NSPersistentContainer
    
    
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Racoon")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        // Чтобы вью автоматически видела 
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveContext () {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
