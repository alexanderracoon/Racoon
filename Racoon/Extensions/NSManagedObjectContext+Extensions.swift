//
//  NSManagedObjectContext.swift
//  Racoon
//
//  Created by Александр Переславцев on 14.04.2026.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func fetchAll<T> (type: T.Type) throws -> [T] where T: NSManagedObject {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        return try fetch(request)
    }
    
    func fetch<T> (id: UUID, type: T.Type) throws -> T? where T : NSManagedObject {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        return try fetch(request).first
    }
}
