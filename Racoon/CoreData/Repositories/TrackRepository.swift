//
//  TrackRepository.swift
//  Racoon
//
//  Created by Александр Переславцев on 12.04.2026.
//

import Foundation
import CoreData


class TrackRepository: TrackRepositoryProtocol {
    private let stack: CoreDataStackProtocol
    private let context: NSManagedObjectContext
    
    init(coreDataStack: CoreDataStackProtocol) {
        self.stack = coreDataStack
        self.context = coreDataStack.context
    }
    
    
    func create(
        id: UUID,
        title: String = "",
        duration: Double = 0,
        fileURL: URL? = nil,
        cover: URL? = nil,
        audioFormat: AudioFormat = .mp3,
        isDownloaded: Bool = false,
        isFavourite: Bool = true,
        timeAdded: Date = Date(),
        timeLastPlayed: Date = Date(),
        timesPlayed: Int32 = 0,) -> Track {
            let track = Track(context: context)
            track.id = id
            track.title = title
            track.duration = duration
            track.fileURL = fileURL
            track.cover = cover
            track.format = audioFormat
            track.isDownloaded = isDownloaded
            track.isFavourite = isFavourite
            track.timeAdded = timeAdded
            track.timeLastPlayed = timeLastPlayed
            track.timesPlayed = timesPlayed
            print("Track Repository id: \(id)")
            // Скорее всего не нужен
            return track
    }
    
    func fetchAll() throws -> [Track] {
        try context.fetchAll(type: Track.self)
    }
    
    func fetch(id: UUID) throws -> Track? {
        try context.fetch(id: id, type: Track.self)
    }
    
    //MARK: - Придумать реализацию
    func update(_ track: Track) {  }
    
    //MARK: - Не забыть удалить файл из FileManager перед удалением в CoreData
    func delete(id: UUID) {
        let request: NSFetchRequest<Track> = Track.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        guard let trackToDelete = try? context.fetch(request).first else {
            return print("Delete Error, Track not found by id: \(id)")
        }
        
        context.delete(trackToDelete)
        
        do { try context.save() } catch { print("Delete Error: \(error)") }
    }
    
    //MARK: - Не забыть удалить файл из FileManager перед удалением в CoreData
    func delete(_ track: Track) {
        context.delete(track)
        do { try context.save() } catch { print("Delete Error: \(error)") }
    }
}





//func createTrack(
//    id: UUID = UUID(),
//    name: String,
//    duration: Double,
//    fileURL: URL?,
//    cover: URL? = nil,
//    audioFormat: AudioFormat? = nil,
//    isDownloaded: Bool = false,
//    isFavourite: Bool = true,
//    timeAdded: Date? = Date(),
//    timeLastPlayed: Date? = nil,
//    timesPlayed: Int32 = 0,
//    
//    albumName: String? = nil,
//    album: Album? = nil,
//    artistName: String? = nil,
//    artist: Artist? = nil,
//    
//    genresNames: [String] = [],
//) -> Track {
//    let track = Track(context: context)
//    track.id = id
//    track.name = name
//    track.duration = duration
//    track.fileURL = fileURL
//    track.cover = cover
//    track.format = audioFormat ?? .mp3
//    track.isDownloaded = isDownloaded
//    track.isFavourite = isFavourite
//    track.timeAdded = timeAdded
//    track.timeLastPlayed = timeLastPlayed
//    track.timesPlayed = timesPlayed
//    
//    // MARK: Attach album to track
//    if let album {
//        track.album = album
//    } else if let albumName{
//        let album = Album(context: context)
//        album.name = albumName
//        album.id = UUID()
//        track.album = album
//    }
//    
//    // MARK: Attach artist to track and album
//    let finalArtist: Artist?
//
//    if let artist {
//        finalArtist = artist
//    } else if let artistName{
//        let newArtist = Artist(context: context)
//        newArtist.name = artistName
//        newArtist.id = UUID()
//        finalArtist = newArtist
//    } else { finalArtist = nil }
//    
//    if let artist = finalArtist {
//        track.addToArtists(artist)
//        track.album?.addToArtist(artist)
//    }
//    
//    genresNames.forEach { name in
//        let genre = fetchOrCreateGenre(by: name)
//        track.addToGenres(genre)
//    }
//    
//    save()
//    return track
//}
