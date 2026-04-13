//
//  TrackRepositoryProtocol.swift
//  Racoon
//
//  Created by Александр Переславцев on 13.04.2026.
//

import Foundation


protocol TrackRepositoryProtocol {
    func create(
        id: UUID,
        name: String,
        duration: Double,
        fileURL: URL?,
        cover: URL?,
        audioFormat: AudioFormat,
        isDownloaded: Bool,
        isFavourite: Bool,
        timeAdded: Date,
        timeLastPlayed: Date,
        timesPlayed: Int32,
//        albumName: String?,
//        album: Album?,
//        artistName: String?,
//        artist: Artist?,
//        genresNames: [String],
    ) -> Track
    func fetchAll() throws -> [Track]
    func fetch(with id: UUID) throws -> Track?
    func update(_ track: Track)
    func delete(with id: UUID)
}
