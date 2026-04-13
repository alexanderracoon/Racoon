//
//  ArtistRepositoryProtocol.swift
//  Racoon
//
//  Created by Александр Переславцев on 13.04.2026.
//

import Foundation

protocol ArtistRepositoryProtocol {
    func create(
        id: UUID,
        cover: URL?,
        name: String) -> Artist
    func fetchAll() throws -> [Artist]
    func fetch(with id: UUID) throws -> Artist?
    func update(_ artist: Artist)
    func delete(with id: UUID)
}
