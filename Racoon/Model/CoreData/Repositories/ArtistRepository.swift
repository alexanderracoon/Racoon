//
//  ArtistRepository.swift
//  Racoon
//
//  Created by Александр Переславцев on 13.04.2026.
//

import Foundation
import CoreData

///Класс, управляющий сущностью ``Artist`` в CoreData
class ArtistRepository: ArtistRepositoryProtocol {
    private let stack: CoreDataStackProtocol
    private let context: NSManagedObjectContext
    
    init(coreDataStack: CoreDataStackProtocol) {
        self.stack = coreDataStack
        self.context = coreDataStack.context
    }
    
    //MARK: - Переписать,чтобы было не нужно?
    ///Ищет ``Artist`` по имени. Находит – возвращает, не находит – создаёт артиста с таким именем
    /// - Parameters:
    ///     - name: Имя ``Artist``
    /// - Returns: ``Artist``

    func findOrCreate(name: String) -> Artist {
        let request: NSFetchRequest<Artist> = Artist.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        request.fetchLimit = 1
        
        if let existing = try? context.fetch(request).first {
            return existing
        }
        //MARK: - Доработать
        return create(id: UUID(), name: name)
    }
    
    //MARK: - Доработать
    ///Создаёт ``Artist``
    /// - Parameters:
    ///     - id: ``UUID``
    ///     - cover: Путь к файлу с обложкой ``Artist``
    ///     - name: Имя ``Artist``
    /// - Returns: ``Artist``
    func create(
        id: UUID,
        cover: URL? = nil,
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
    
    func fetch(id: UUID) throws -> Artist? {
        try context.fetch(id: id, type: Artist.self)
    }
    
    func update(_ artist: Artist) {
        
    }
    
    //MARK: - Связи перед улаением сами удалятся из-за настроек модели
    func delete(id: UUID) {
        let request: NSFetchRequest<Artist> = Artist.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        guard let artistToDelete = try? context.fetch(request).first else {
            return print("Delete Error, Album not found by id: \(id)")
        }
        
        context.delete(artistToDelete)
    }
    
    func delete(_ artist: Artist) {
        context.delete(artist)
        do { try context.save() } catch { print("Delete Error: \(error)") }
    }
}
