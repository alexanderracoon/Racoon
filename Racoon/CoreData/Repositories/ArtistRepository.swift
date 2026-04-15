//
//  ArtistRepository.swift
//  Racoon
//
//  Created by Александр Переславцев on 13.04.2026.
//

import Foundation
import CoreData


class ArtistRepository: ArtistRepositoryProtocol {
    private let stack: CoreDataStackProtocol
    private let context: NSManagedObjectContext
    
    init(coreDataStack: CoreDataStackProtocol) {
        self.stack = coreDataStack
        self.context = coreDataStack.context
    }
    
    func findOrCreate(name: String) -> Artist {
        let request: NSFetchRequest<Artist> = Artist.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        request.fetchLimit = 1
        
        if let existing = try? context.fetch(request).first {
            return existing
        }
        
        return create(name: name)
    }
    
    //MARK: - Доработать
    func create(cover: URL? = nil,
                name: String) -> Artist {
        let artist = Artist(context: context)
        artist.id = UUID()
        artist.cover = cover
        artist.name = name
        
        return artist
    }
    
    func fetchAll() throws -> [Artist] {
        try context.fetchAll(type: Artist.self)
    }
    
    func fetch(id: UUID) throws -> Artist? {
        try context.fetch(id: id, type: Artist.self)
    }
    
    func update(_ artist: Artist) {
        
    }
    
    //MARK: - Bug? Удалить связи перед улаением
    func delete(id: UUID) {
        let request: NSFetchRequest<Artist> = Artist.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        guard let artistToDelete = try? context.fetch(request).first else {
            return print("Delete Error, Album not found by id: \(id)")
        }
        
        context.delete(artistToDelete)
    }
}
