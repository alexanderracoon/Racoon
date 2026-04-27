//
//  CoreDataStackProtocol.swift
//  Racoon
//
//  Created by Александр Переславцев on 12.04.2026.
//

import CoreData

protocol CoreDataStackProtocol {
    var context: NSManagedObjectContext { get }
    func save() throws
    func rollback()
}
