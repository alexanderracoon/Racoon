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
    
    func create(id: UUID,
                cover: URL?,
                name: String) -> Artist {
        let artist = Artist(context: context)
        artist.id = id
        artist.cover = cover
        artist.name = name
        
        return artist
    }
    
    func fetchAll() throws -> [Artist] {
        try context.fetchAll(type: Artist.self)
    }
    
    func fetch(with id: UUID) throws -> Artist? {
        try context.fetch(with: id, type: Artist.self)
    }
    
    func update(_ artist: Artist) {
        
    }
    
    //MARK: - Bug? Удалить связи перед улаением
    func delete(with id: UUID) {
        let request: NSFetchRequest<Artist> = Artist.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        guard let artistToDelete = try? context.fetch(request).first else {
            return print("Delete Error, Album not found by id: \(id)")
        }
        
        context.delete(artistToDelete)
    }
}
