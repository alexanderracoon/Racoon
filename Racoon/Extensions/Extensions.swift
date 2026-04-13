//
//  Extensions.swift
//  Racoon
//
//  Created by Александр Переславцев on 01.04.2026.
//

import Foundation
import CoreData

extension Collection {
    var isNotEmpty: Bool {
        !isEmpty
    }
}

extension NSManagedObjectContext {
    func fetchAll<T> (type: T.Type) throws -> [T] where T: NSManagedObject {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        return try fetch(request)
    }
    
    func fetch<T> (with id: UUID, type: T.Type) throws -> T? where T : NSManagedObject {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        return try fetch(request).first
    }
}
