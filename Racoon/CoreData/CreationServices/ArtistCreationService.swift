//
//  ArtistCreationService.swift
//  Racoon
//
//  Created by Александр Переславцев on 01.05.2026.
//

import Foundation

class ArtistCreationService {
    private let stack: CoreDataStackProtocol
    private let artistRepository: ArtistRepositoryProtocol
    private let mediaStorage: LocalMediaStorage
    init(
        stack: CoreDataStackProtocol,
//        trackRepository: TrackRepositoryProtocol,
//        albumRepository: AlbumRepositoryProtocol,
        artistRepository: ArtistRepositoryProtocol,
//        genreRepository: GenreRepositoryProtocol,
        //MARK: - Protocol?
        mediaStorage: LocalMediaStorage
    ) {
        self.stack = stack
//        self.trackRepository = trackRepository
//        self.albumRepository = albumRepository
        self.artistRepository = artistRepository
//        self.genreRepository = genreRepository
        self.mediaStorage = mediaStorage
    }
    
    func createArtist(artistDTO: ArtistDTO) throws -> Void {
        let artistID = UUID()
        let artistCoverPath = mediaStorage.saveArtistCover(data: artistDTO.artistCoverData, artistID: artistID)
        
        artistRepository.create(id: artistID, cover: artistCoverPath, name: artistDTO.name)
        
        do {
            try stack.save()
        } catch {
            mediaStorage.removeArtistCover(artistID: artistID)
            stack.rollback()
            throw error
        }
    }
    
}
