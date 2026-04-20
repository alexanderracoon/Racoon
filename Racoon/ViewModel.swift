//
//  ViewModel.swift
//  Racoon
//
//  Created by Александр Переславцев on 14.04.2026.
//

import Foundation


@Observable
class ViewModel {
    let trackCreationService: TrackCreationService
    let trackRepository: TrackRepositoryProtocol
    let albumRepository: AlbumRepositoryProtocol
    let artistRepository: ArtistRepositoryProtocol
    let genreRepository: GenreRepositoryProtocol
    
    var tracks: [Track] = []
    var albums: [Album] = []
    var artists: [Artist] = []
    
    func loadTracks() { tracks = fetchAllTracks() }

    
    init() {
        let stack = CoreDataStack()
        self.trackRepository = TrackRepository(coreDataStack: stack)
        self.albumRepository = AlbumRepository(coreDataStack: stack)
        self.artistRepository = ArtistRepository(coreDataStack: stack)
        self.genreRepository = GenreRepository(coreDataStack: stack)
        self.trackCreationService = TrackCreationService(
            stack: stack,
            trackRepository: trackRepository,
            albumRepository: albumRepository,
            artistRepository: artistRepository,
            genreRepository: genreRepository
        )
        loadTracks()
    }
    
    func createTrack(
        title: String,
        duration: Double,
        audioFormat: AudioFormat,
        isDownloaded: Bool,
        isFavourite: Bool,
        timeAdded: Date,
        timeLastPlayed: Date,
        timesPlayed: Int32,
        albumName: String,
        artistName: String,
        genreName: String
    ) {
        trackCreationService.createTrack(
            title: title,
            duration: duration,
            audioFormat: audioFormat,
            isDownloaded: isDownloaded,
            isFavourite: isFavourite,
            timeAdded: timeAdded,
            timeLastPlayed: timeLastPlayed,
            timesPlayed: timesPlayed,
            albumTitle: albumName,
            artistName: artistName,
            genreName: genreName)
        loadData()
    }
    
    //MARK: - Read
    //MARK: - заменить на дженерики типо fetchAll<T>( () throws -> <T> ) -> [T] и придумать что делать с репозиторием, может тоже сделать дженерик репозиторий
    func fetchAllTracks() -> [Track] {
        do {
            return try trackRepository.fetchAll()
        } catch {
            print("FetchAllTracks Error: \(error)")
            return []
        }
    }
    
    func fetchAlbum(id: UUID) -> Album? {
        do {
            return try albumRepository.fetch(id: id)
        } catch {
            print("FetchAlbum Error: \(error)")
            return nil
        }
    }
    
    func fetchArtist(id: UUID) -> Artist? {
        do {
            return try artistRepository.fetch(id: id)
        } catch {
            print("FetchArtist Error: \(error)")
            return nil
        }
    }
    
    func fetchAllAlbums() -> [Album] {
        do {
            return try albumRepository.fetchAll()
        } catch {
            print("FetchAllAlbums Error: \(error)")
            return []
        }
    }
    
    func fetchAllArtists() -> [Artist] {
        do {
            return try artistRepository.fetchAll()
        } catch {
            print("FetchAllArtists Error: \(error)")
            return []
        }
    }
    
    //MARK: - Delete
    func deleteTrack(id: UUID) {
        trackRepository.delete(id: id)
    }
    
    func deleteAlbum(id: UUID) {
        albumRepository.delete(id: id)
    }
    
    func deleteArtist(id: UUID) {
        artistRepository.delete(id: id)
    }
    
    func deleteGenre(id: UUID) {
        genreRepository.delete(id: id)
    }
    
    
    //MARK: - Пока не нужно
    func loadData() {
        tracks = fetchAllTracks()
        albums = fetchAllAlbums()
        artists = fetchAllArtists()
    }
}
