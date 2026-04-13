//
//  AlbumRepositoryProtocol.swift
//  Racoon
//
//  Created by Александр Переславцев on 13.04.2026.
//

import Foundation

protocol AlbumRepositoryProtocol {
    func create(
        id: UUID,
        cover: URL?,
        name: String,
        releaseDate: Date) -> Album
    func fetchAll() throws -> [Album]
    func fetch(with id: UUID) throws -> Album?
    func update(_ album: Album)
    func delete(with id: UUID)
}
