//
//  GenreCreationService.swift
//  Racoon
//
//  Created by Александр Переславцев on 01.05.2026.
//

import Foundation

class GenreCreationService {
    private let stack: CoreDataStackProtocol
    private let genreRepository: GenreRepositoryProtocol
    private let mediaStorage: LocalMediaStorage
    init(
        stack: CoreDataStackProtocol,
        genreRepository: GenreRepositoryProtocol,
        //MARK: - Protocol?
        mediaStorage: LocalMediaStorage
    ) {
        self.stack = stack
        self.genreRepository = genreRepository
        self.mediaStorage = mediaStorage
    }
    
    func create() {
        
    }
}
