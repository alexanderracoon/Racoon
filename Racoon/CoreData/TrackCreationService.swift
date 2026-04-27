//
//  TrackCreationService.swift
//  Racoon
//
//  Created by Александр Переславцев on 13.04.2026.
//

import Foundation


class TrackCreationService {
    private let stack: CoreDataStackProtocol
    private let trackRepository: TrackRepositoryProtocol
    private let albumRepository: AlbumRepositoryProtocol
    private let artistRepository: ArtistRepositoryProtocol
    private let genreRepository: GenreRepositoryProtocol
    
    private let mediaStorage: LocalMediaStorage
    
    init(
        stack: CoreDataStackProtocol,
        trackRepository: TrackRepositoryProtocol,
        albumRepository: AlbumRepositoryProtocol,
        artistRepository: ArtistRepositoryProtocol,
        genreRepository: GenreRepositoryProtocol,
        //MARK: - Protocol? 
        mediaStorage: LocalMediaStorage
    ) {
        self.stack = stack
        self.trackRepository = trackRepository
        self.albumRepository = albumRepository
        self.artistRepository = artistRepository
        self.genreRepository = genreRepository
        self.mediaStorage = mediaStorage
    }
    
    func createTrack(
        title: String,
        duration: Double,
        fileURL: URL? = nil,
        cover: URL? = nil,
        audioFormat: AudioFormat,
        isDownloaded: Bool,
        isFavourite: Bool,
        timeAdded: Date,
        timeLastPlayed: Date,
        timesPlayed: Int32,
        trackData: Data,
        albumTitle: String,
        album: Album?,
        artistName: String,
        artist: Artist?,
        genreName: String
//        albumCover: URL?,
//        albumReleaseDate: Date,
//        artistCover: URL?,
    ) throws
//    -> Track
    {
        let trackID = UUID()
        let trackPath: URL = mediaStorage.saveAudio(data: trackData, trackID: trackID, format: audioFormat)
        
        let track = trackRepository.create(
            id : trackID,
            title: title,
            duration: duration,
            fileURL: trackPath,
            cover: cover,
            audioFormat: audioFormat,
            isDownloaded: isDownloaded,
            isFavourite: isFavourite,
            timeAdded: timeAdded,
            timeLastPlayed: timeLastPlayed,
            timesPlayed: timesPlayed
        )
        var myAlbum: Album
        if let album = album {
            myAlbum = album
        } else {
            //MARK: - Такого быть не должно
            print("TrackCreationService: Не найден альбом с таким названием: \(albumTitle). Создаём новый")
            myAlbum = albumRepository.findOrCreate(title: albumTitle)
        }
//        let albumFromName = albumRepository.findOrCreate(
//            title: albumTitle,
//            //            cover: albumCover,
//            //            releaseDate: albumReleaseDate
//        )
        var myArtist: Artist
        if let artist = artist {
            myArtist = artist
        } else {
            print("TrackCreationService: Не найден артист с таким именем: \(artistName). Создаём нового")
            myArtist = artistRepository.findOrCreate(name: artistName)
        }
        
        let genre = genreRepository.findOrCreate(name: genreName)
        
        createRelationships(track: track, album: myAlbum, artist: myArtist, genre: genre)
        
        do {
            try stack.save()
        } catch {
            mediaStorage.deleteFile(at: trackPath)
            stack.rollback()
            throw error
        }
//        return track
    }
    
    private func createRelationships(track: Track, album: Album?, artist: Artist?, genre: Genre?) {
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
    }
}
