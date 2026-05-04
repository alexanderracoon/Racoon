//
//  RelationshipCreationService.swift
//  Racoon
//
//  Created by Александр Переславцев on 01.05.2026.
//


class RelationshipCreationService {
    func addRelationship() {
        
    }
    
    func createRelationships(track: Track, album: Album?, artist: Artist?, genre: Genre?) {
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