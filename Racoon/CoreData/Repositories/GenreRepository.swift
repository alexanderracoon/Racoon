//
//  Genres.swift
//  Racoon
//
//  Created by Александр Переславцев on 13.04.2026.
//

import Foundation
import CoreData

class GenreRepository: GenreRepositoryProtocol {
    private let stack: CoreDataStackProtocol
    private let context: NSManagedObjectContext
    
    init(coreDataStack: CoreDataStackProtocol) {
        self.stack = coreDataStack
        self.context = coreDataStack.context
    }

    func findOrCreate(name: String) -> Genre {
        let request: NSFetchRequest<Genre> = Genre.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        request.fetchLimit = 1
        
        if let existing = try? context.fetch(request).first {
            return existing
        }
        //MARK: - Доделать/переделать
        return create(id: UUID(), name: name)
    }
    
    func create(id: UUID, name: String) -> Genre {
        let genre = Genre(context: context)
        genre.id = UUID()
        genre.name = name
        
        return genre
    }
    
    func fetchAll() throws -> [Genre] {
        try context.fetchAll(type: Genre.self)
    }
    
    func fetch(id: UUID) throws -> Genre? {
        try context.fetch(id: id, type: Genre.self)
    }
    
    func update(_ genre: Genre) {
        
    }
    
    func delete(name: String) {
        let request: NSFetchRequest<Genre> = Genre.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        request.fetchLimit = 1
        
        if let existing = try? context.fetch(request).first {
            print("Deleting Genre: \(existing.name ?? "Unknown")")
            context.delete(existing)
        } else {
            return print("Detele Genre error")
        }
    }
    
    func delete(id: UUID) {
        let request: NSFetchRequest<Genre> = Genre.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        guard let genreToDelete = try? context.fetch(request).first else {
            return print("Delete Error, Genre not found by id: \(id)")
        }
        
        context.delete(genreToDelete)
    }
    
    func delete(_ genre: Genre) {
        context.delete(genre)
        do { try context.save() } catch { print("Delete Error: \(error)") }
    }
}
