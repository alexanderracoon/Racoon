//
//  AlbumRepositoryProtocol.swift
//  Racoon
//
//  Created by Александр Переславцев on 12.04.2026.
//

import Foundation
import CoreData


class AlbumRepository: AlbumRepositoryProtocol {
    private let stack: CoreDataStackProtocol
    private let context: NSManagedObjectContext
    
    init(coreDataStack: CoreDataStackProtocol) {
        self.stack = coreDataStack
        self.context = coreDataStack.context
    }

    func create(id: UUID = UUID(),
                cover: URL? = nil,
                name: String = "",
                releaseDate: Date = Date()
    ) -> Album {
        let album = Album(context: context)
        album.id = id
        album.cover = cover
        album.name = name
        album.releaseDate = releaseDate
        
        return album
    }
    
    func fetchAll() throws -> [Album] {
        try context.fetchAll(type: Album.self)
    }
    
    func fetch(with id: UUID) throws -> Album? {
        try context.fetch(with: id, type: Album.self)
    }
    
    func update(_ album: Album) {
        
    }
    
    //MARK: - Bug? Удалить связи перед улаением
    func delete(with id: UUID) {
        let request: NSFetchRequest<Album> = Album.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        guard let albumToDelete = try? context.fetch(request).first else {
            return print("Delete Error, Album not found by id: \(id)")
        }
        context.delete(albumToDelete)
    }
}
