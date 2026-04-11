//
//  CoreDataManager.swift
//  Racoon
//
//  Created by Александр Переславцев on 07.04.2026.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
//    private init() {}
        
    private let container: NSPersistentContainer
    private var context: NSManagedObjectContext { container.viewContext }
    
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Racoon")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        // Чтобы вью автоматически видела
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    private func saveContext () {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("CoreData saveContext error ", error.localizedDescription)
        }
    }
    //MARK: - Добавить crud функции чтобы соответствовать солиду
    
    @discardableResult
    func createTrack(
        id: UUID = UUID(),
        name: String,
        duration: Double,
        fileURL: URL?,
        cover: URL? = nil,
        audioFormat: AudioFormat? = nil,
        isDownloaded: Bool = false,
        isFavourite: Bool = true,
        timeAdded: Date = Date(),
        timeLastPlayed: Date? = nil,
        timesPlayed: Int32 = 0,
        
        albumName: String? = nil,
        album: Album? = nil,
        artistName: String? = nil,
        artist: Artist? = nil,
        
        genresNames: [String] = [],
    ) -> Track {
        let track = Track(context: context)
        track.id = id
        track.name = name
        track.duration = duration
        track.fileURL = fileURL
        track.cover = cover
        track.format = audioFormat ?? .mp3
        track.isDownloaded = isDownloaded
        track.isFavourite = isFavourite
        track.timeAdded = timeAdded
        track.timeLastPlayed = timeLastPlayed
        track.timesPlayed = timesPlayed
        
        // MARK: Attach album to track
        if let album {
            track.album = album
        } else if let albumName{
            let album = Album(context: context)
            album.name = albumName
            album.id = UUID()
            track.album = album
        }
        
        // MARK: Attach artist to track and album
        let finalArtist: Artist?

        if let artist {
            finalArtist = artist
        } else if let artistName{
            let newArtist = Artist(context: context)
            newArtist.name = artistName
            newArtist.id = UUID()
            finalArtist = newArtist
        } else { finalArtist = nil }
        
        if let artist = finalArtist {
            track.addToArtists(artist)
            track.album?.addToArtist(artist)
        }
        
        genresNames.forEach { name in
            let genre = fetchOrCreateGenre(by: name)
            track.addToGenres(genre)
        }
        
        saveContext()
        return track
    }
    
    func fetchAllTracks() -> [Track] {
        let request: NSFetchRequest<Track> = Track.fetchRequest()
//        let predicate = NSPredicate(format: "isFavourite == true")
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch tracks: \(error)")
            return []
        }
    }
    
    func updateTrack(id: UUID, with newTrack: Track) {
        let request: NSFetchRequest<Track> = Track.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        guard let oldTrack = try? context.fetch(request).first else {
            return print("Update Error, Track not found by id: \(id)")
        }
        
        //Меняем значения в oldTrack на новые из newTrack, но id оставляем старый
        oldTrack.id = newTrack.id
        oldTrack.name = newTrack.name
        oldTrack.duration = newTrack.duration
        oldTrack.fileURL = newTrack.fileURL
        oldTrack.cover = newTrack.cover
        oldTrack.format = newTrack.format
        oldTrack.isDownloaded = newTrack.isDownloaded
        oldTrack.isFavourite = newTrack.isFavourite
        oldTrack.timeAdded = newTrack.timeAdded
        oldTrack.timeLastPlayed = newTrack.timeLastPlayed
        oldTrack.timesPlayed = newTrack.timesPlayed
        oldTrack.album = newTrack.album
        
//        if let artists = oldTrack.artists {
//            oldTrack.removeFromArtists(artists)
//        }
//        oldTrack.addToArtists(newTrack.artists)
//        oldTrack.artists = newTrack.artists
      
        //MARK: - Возможно баг, проверить в базе данных
        var artists = oldTrack.artistsSet
        artists.removeAll()
        // Вычисляемое свойство, нужно прямо установить пустой Set через сетер
        oldTrack.artistsSet = artists
        newTrack.artistsSet.forEach { oldTrack.addToArtists($0) }
        
        var genres = oldTrack.genresSet
        genres.removeAll()
        oldTrack.genresSet = genres
        newTrack.genresSet.forEach { oldTrack.addToGenres($0) }
//        oldTrack.genres = newTrack.genres
    
        saveContext()
    }
    
    func deleteTrack(with id: UUID) {
        let request: NSFetchRequest<Track> = Track.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        guard let trackToDelete = try? context.fetch(request).first else {
            return print("Delete Error, Track not found by id: \(id)")
        }
        
        context.delete(trackToDelete)
        saveContext()
    }
    
    func deleteAllTracks() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Track")
        do {
            let tracks = try? context.fetch(request) as? [Track]
            tracks?.forEach { context.delete($0) }
        }
        saveContext()
    }
    
    private func fetchOrCreateGenre(by name: String) -> Genre {
        let request: NSFetchRequest<Genre> = Genre.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        request.fetchLimit = 1
        
        if let existing = try? context.fetch(request).first {
            return existing
        }
        
        let genre = Genre(context: context)
        genre.name = name
        genre.id = UUID()
        return genre
    }
}

func addTrack(name: String = "Name",
              artist: String = "Artist",
              genre: String = "Genre",
              year: Int16 = 0,
              duration: Double = 0,
              completion: @escaping (Result<Track, Error>) -> Void
) {}
