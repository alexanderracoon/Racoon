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
    
    init(
        stack: CoreDataStackProtocol,
        trackRepository: TrackRepositoryProtocol,
        albumRepository: AlbumRepositoryProtocol,
        artistRepository: ArtistRepositoryProtocol,
        genreRepository: GenreRepositoryProtocol
    ) {
        self.stack = stack
        self.trackRepository = trackRepository
        self.albumRepository = albumRepository
        self.artistRepository = artistRepository
        self.genreRepository = genreRepository
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
        albumTitle: String,
        artistName: String,
        genreName: String
//        albumCover: URL?,
//        albumReleaseDate: Date,
//        artistCover: URL?,
    )
//    -> Track
    {
        let track = trackRepository.create(
            title: title,
            duration: duration,
            fileURL: fileURL,
            cover: cover,
            audioFormat: audioFormat,
            isDownloaded: isDownloaded,
            isFavourite: isFavourite,
            timeAdded: timeAdded,
            timeLastPlayed: timeLastPlayed,
            timesPlayed: timesPlayed
        )
        let album = albumRepository.findOrCreate(
            title: albumTitle,
//            cover: albumCover,
//            releaseDate: albumReleaseDate
        )
        let artist = artistRepository.findOrCreate(
//            cover: artistCover,
            name: artistName
        )
        let genre = genreRepository.findOrCreate(name: genreName)
        
        createRelationships(track: track, album: album, artist: artist, genre: genre)
        
        stack.save()
//        return track
    }
    
    private func createRelationships(track: Track, album: Album, artist: Artist, genre: Genre) {
        artist.addToAlbums(album)
        track.addToArtists(artist)
        track.album = album
        track.addToGenres(genre)
    }
}
