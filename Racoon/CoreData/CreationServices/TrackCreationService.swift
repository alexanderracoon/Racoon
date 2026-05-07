//
//  TrackCreationService.swift
//  Racoon
//
//  Created by Александр Переславцев on 01.05.2026.
//

import Foundation

///Создаёт трек и связи с артистом, альбомом, жанрами
class TrackCreationService {
    private let stack: CoreDataStackProtocol
    private let trackRepository: TrackRepositoryProtocol
    private let mediaStorage: LocalMediaStorage
    
    init(
        stack: CoreDataStackProtocol,
        trackRepository: TrackRepositoryProtocol,
//        albumRepository: AlbumRepositoryProtocol,
//        artistRepository: ArtistRepositoryProtocol,
//        genreRepository: GenreRepositoryProtocol,
        //MARK: - Protocol?
        mediaStorage: LocalMediaStorage
    ) {
        self.stack = stack
        self.trackRepository = trackRepository
//        self.albumRepository = albumRepository
//        self.artistRepository = artistRepository
//        self.genreRepository = genreRepository
        self.mediaStorage = mediaStorage
    }
    
    func create(trackDTO: TrackDTO) throws {
        //MARK: - Создание Track, без связей
        let trackID = UUID()
        let trackPath: URL = mediaStorage.saveAudio(data: trackDTO.trackData, trackID: trackID, format: trackDTO.audioFormat)
        let coverPath: URL = mediaStorage.saveTrackCover(data: trackDTO.trackCoverData,trackID: trackID)
        
        let track = trackRepository.create(
            id : trackID,
            title: trackDTO.title,
            duration: trackDTO.duration,
            fileURL: trackPath,
            cover: coverPath,
            audioFormat: trackDTO.audioFormat,
            isDownloaded: trackDTO.isDownloaded,
            isFavourite: trackDTO.isFavourite,
            releaseDate: trackDTO.releaseDate,
            timeAdded: trackDTO.timeAdded,
            timeLastPlayed: trackDTO.timeLastPlayed,
            timesPlayed: trackDTO.timesPlayed
        )
        
        //MARK: - Жанры поправить
        let genre = GenreRepository(coreDataStack: stack).create(id: UUID(), name: trackDTO.genreName)

        let genres = trackDTO.genres
        
        //MARK: - Relationships
        createRelationships(track: track, album: trackDTO.album, artist: trackDTO.artist, genre: genre, genres: genres)
        
        
        do {
            try stack.save()
        } catch {
            mediaStorage.deleteFile(at: trackPath)
            mediaStorage.removeTrackCover(trackID: trackID)
            stack.rollback()
            throw error
        }
    }
    
    func createRelationships(track: Track, album: Album?, artist: Artist?, genre: Genre?, genres: [Genre]) {
        if let album = album {
            track.album = album
        }
        if let artist = artist {
            track.addToArtists(artist)
        }
        if let album = album, let artist = artist {
            artist.addToAlbums(album)
        }
        if let genre = genre {
            track.addToGenres(genre)
        }
        genres.forEach { track.addToGenres($0) }
    }

}
