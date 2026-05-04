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
    let artistCreationService: ArtistCreationService
    let albumCreationService: AlbumCreationService
    let genreRepository: GenreRepositoryProtocol
    //MARK: - Protocol?
    let mediaStorage: LocalMediaStorage
    
    var tracks: [Track] = []
    var albums: [Album] = []
    var artists: [Artist] = []
    var genres: [Genre] = []
    var seceltedGenres: [Genre] = []
    func loadTracks() { tracks = fetchAllTracks() }

    func checkGenres(selectedGenres: Set<UUID>) -> [Genre] {
        genres.filter { genre in
            guard let id = genre.id else { return false }
            return selectedGenres.contains(id)
        }
    }
    
    init() {
        let stack = CoreDataStack()
        self.trackRepository = TrackRepository(coreDataStack: stack)
        self.albumRepository = AlbumRepository(coreDataStack: stack)
        self.artistRepository = ArtistRepository(coreDataStack: stack)
        self.genreRepository = GenreRepository(coreDataStack: stack)
        self.mediaStorage = LocalMediaStorage()
        self.trackCreationService = TrackCreationService(stack: stack, trackRepository: trackRepository, mediaStorage: mediaStorage)
        self.artistCreationService = ArtistCreationService(stack: stack, artistRepository: artistRepository, mediaStorage: mediaStorage)
        self.albumCreationService = AlbumCreationService(stack: stack, albumRepository: albumRepository, mediaStorage: mediaStorage)
//        self.trackCreationService = SongCreationService(
//            stack: stack,
//            trackRepository: trackRepository,
//            albumRepository: albumRepository,
//            artistRepository: artistRepository,
//            genreRepository: genreRepository,
//            mediaStorage: mediaStorage
//        )
//        loadTracks()
        loadData()
    }
    
//    func createTrack(
//        title: String,
//        duration: Double,
//        audioFormat: AudioFormat,
//        trackCoverData: Data,
//        isDownloaded: Bool,
//        isFavourite: Bool,
//        timeAdded: Date,
//        timeLastPlayed: Date,
//        timesPlayed: Int32,
//        trackData: Data,
//        albumName: String = "",
//        album: Album? = nil,
//        artistName: String = "",
//        artist: Artist? = nil,
//        genreName: String
//    ) {
//        do {
//            try trackCreationService.createTrack(
//                title: title,
//                duration: duration,
//                audioFormat: audioFormat,
//                trackCoverData: trackCoverData,
//                isDownloaded: isDownloaded,
//                isFavourite: isFavourite,
//                timeAdded: timeAdded,
//                timeLastPlayed: timeLastPlayed,
//                timesPlayed: timesPlayed,
//                trackData: trackData,
//                albumTitle: albumName,
//                album: album,
//                artistName: artistName,
//                artist: artist,
//                genreName: genreName)
//            loadData()
//        } catch let error as NSError {
//            print("CoreData saveContext error ", error.localizedDescription)
//            print("Save error: \(error)")
//        }
//    }
    
    func createTrack(_ trackDTO: TrackDTO) {
        do {
//            trackDTO.genres = seceltedGenres
            try trackCreationService.create(trackDTO: trackDTO)
            loadData()
        } catch let error as NSError {
            print("CoreData saveContext error ", error.localizedDescription)
            print("Save error: \(error)")
        }
    }
    
    func createAlbum(_ albumDTO: AlbumDTO) {
        do {
            try albumCreationService.create(albumDTO: albumDTO)
            loadData()
        } catch let error as NSError {
            print("CoreData saveContext error ", error.localizedDescription)
            print("Save error: \(error)")
        }
    }
    
    func createArtist(_ artistDTO: ArtistDTO) {
        do {
            try artistCreationService.create(artistDTO: artistDTO)
            loadData()
        } catch let error as NSError {
            print("CoreData saveContext error ", error.localizedDescription)
            print("Save error: \(error)")
        }
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
    
    func fetchAllGenres() -> [Genre] {
        do {
            return try genreRepository.fetchAll()
        } catch {
            print("FetchAllGenres Error: \(error)")
            return []
        }
    }
    //MARK: - Delete
//    func deleteTrack(id: UUID) {
//        trackRepository.delete(id: id)
//        loadData()
//    }
    
    func deleteTrack(_ track: Track) {
        let trackID = track.id
        let trackFormat = track.format
        trackRepository.delete(track)
        mediaStorage.removeAudio(trackID: trackID, format: trackFormat)
        mediaStorage.removeTrackCover(trackID: trackID)
        loadData()
    }
    func deleteAlbum(_ album: Album) {
        let albumID = album.id
        //MARK: - Придумать где реализовывать
        albumRepository.delete(album)
        mediaStorage.removeAlbumCover(albumID: albumID)
//        mediaStorage.removeAudio(trackID: trackID, format: trackFormat)
        loadData()
    }
    
    func deleteArtist(_ artist: Artist) {
        let artistID = artist.id
        //MARK: - Придумать где реализовывать
        artistRepository.delete(artist)
        mediaStorage.removeArtistCover(artistID: artistID)
//        mediaStorage.removeAudio(trackID: trackID, format: trackFormat)
        loadData()
    }
    
    func deleteTrack(indexSet: IndexSet) {
        for index in indexSet {
            let track = tracks[index]
            deleteTrack(track)
//            deleteTrack(track: track)
//            guard let id = tracks[index].id else { continue }
//            deleteTrack(id: id)
        }
//        loadData()
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
    
    func deleteGenre(_ genre: Genre) {
        genreRepository.delete(genre)
    }
    
    
    //MARK: - Пока не нужно
    func loadData() {
        tracks = fetchAllTracks()
        albums = fetchAllAlbums()
        artists = fetchAllArtists()
        genres = fetchAllGenres()
    }
}
