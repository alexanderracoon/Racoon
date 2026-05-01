//
//  AlbumCreationService.swift
//  Racoon
//
//  Created by Александр Переславцев on 01.05.2026.
//

import Foundation

class AlbumCreationService {
    private let stack: CoreDataStackProtocol
    private let albumRepository: AlbumRepositoryProtocol
    private let mediaStorage: LocalMediaStorage
    
    init(
        stack: CoreDataStackProtocol,
        albumRepository: AlbumRepositoryProtocol,
        //MARK: - Protocol?
        mediaStorage: LocalMediaStorage
    ) {
        self.stack = stack
        self.albumRepository = albumRepository
        self.mediaStorage = mediaStorage
    }
    
    func createAlbum(albumDTO: AlbumDTO) throws -> Void {
        let albumID = UUID()
        let albumCoverPath = mediaStorage.saveAlbumCover(data: albumDTO.albumCoverData, albumID: albumID)
        
        albumRepository.create(id: albumID, cover: albumCoverPath, title: albumDTO.title, releaseDate: albumDTO.releaseDate)
        
        do {
            try stack.save()
        } catch {
            mediaStorage.removeAlbumCover(albumID: albumID)
            stack.rollback()
            throw error
        }
    }
}
