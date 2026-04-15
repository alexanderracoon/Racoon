//
//  GenreRepositoryProtocol.swift
//  Racoon
//
//  Created by Александр Переславцев on 13.04.2026.
//

import Foundation

protocol GenreRepositoryProtocol {
    func create(
        name: String) -> Genre
    func findOrCreate(name: String) -> Genre
    func fetchAll() throws -> [Genre]
    func fetch(id: UUID) throws -> Genre?
    func update(_ genre: Genre)
    func delete(id: UUID)
}
