//
//  AlbumCreationService.swift
//  Racoon
//
//  Created by Александр Переславцев on 01.05.2026.
//

import Foundation

///Создаёт Альбом и связи с артистом и треком
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
    
    func create(albumDTO: AlbumDTO) throws -> Void {
        let albumID = UUID()
        let albumCoverPath = mediaStorage.saveAlbumCover(data: albumDTO.albumCoverData, albumID: albumID)
        
        let album = albumRepository.create(id: albumID, cover: albumCoverPath, title: albumDTO.title, releaseDate: albumDTO.releaseDate)
        
        if let track = albumDTO.track {
            album.addToTracks(track)
        }
        if let artist = albumDTO.artist {
            album.addToArtists(artist)
        }
        
        do {
            try stack.save()
        } catch {
            mediaStorage.removeAlbumCover(albumID: albumID)
            stack.rollback()
            throw error
        }
    }
}
