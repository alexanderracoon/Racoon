//
//  ArtistRepositoryProtocol.swift
//  Racoon
//
//  Created by Александр Переславцев on 13.04.2026.
//

import Foundation

protocol ArtistRepositoryProtocol {
    func create(
        cover: URL?,
        name: String) -> Artist
    //MARK: - Доработать в будущем
    func findOrCreate(name: String) -> Artist
    func fetchAll() throws -> [Artist]
    func fetch(id: UUID) throws -> Artist?
    func update(_ artist: Artist)
    func delete(id: UUID)
    func delete(_ artist: Artist)
}

//protocol ArtistRepositoryProtocol: RepositoryProtocol where Entity == Artist {
//    func create(
//        cover: URL?,
//        name: String) -> Artist
//    func findOrCreate(name: String) -> Artist
//}
//
//protocol RepositoryProtocol {
//    associatedtype Entity
//    
//    func fetchAll() throws -> [Entity]
//    func fetch(id: UUID) throws -> Entity?
//    func update(_ entity: Entity)
//    func delete(id: UUID)
//}

