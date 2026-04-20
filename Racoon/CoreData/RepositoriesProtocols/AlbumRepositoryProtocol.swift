//
//  AlbumRepositoryProtocol.swift
//  Racoon
//
//  Created by Александр Переславцев on 13.04.2026.
//

import Foundation

protocol AlbumRepositoryProtocol {
    func create(
        cover: URL?,
        title: String,
        releaseDate: Date) -> Album
    //MARK: - Доработать в будущем
    func findOrCreate(title: String) -> Album
    func fetchAll() throws -> [Album]
    func fetch(id: UUID) throws -> Album?
    func update(_ album: Album)
    func delete(id: UUID)
}
