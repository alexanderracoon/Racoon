//
//  CoreDataStack.swift
//  Racoon
//
//  Created by Александр Переславцев on 12.04.2026.
//
import CoreData

final class CoreDataStack: CoreDataStackProtocol {
    let container: NSPersistentContainer
    var context: NSManagedObjectContext { container.viewContext }
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Racoon")
        
        if let description = container.persistentStoreDescriptions.first, inMemory {
            description.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
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
        }
        // Чтобы вью автоматически видела
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    //MARK: - Изменить обработку ошибок
    func save () {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("CoreData saveContext error ", error.localizedDescription)
        }
    }
}
