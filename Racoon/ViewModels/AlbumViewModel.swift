//
//  AlbumViewModel.swift
//  Racoon
//
//  Created by Александр Переславцев on 19.05.2026.
//

import Foundation

@Observable
class AlbumViewModel {
    var album: Album

    let releaseDate: Date
    var title: String { album.title ?? "Blank" }
    var coverURL: URL? { album.cover }

    var artistName: String {
        album.artists
            .sorted { ($0.name ?? "") < ($1.name ?? "") }
            .compactMap(\.name)
            .joined(separator: " ")
    }
    
    var artists: [Artist] {
        album.artists.sorted { ($0.name ?? "") < ($1.name ?? "") }
    }
    
    var sortType: TrackSortType = .releaseDate

    //MARK: - добавить кеш, перерасчитывается 
    var tracks: [Track] {
        switch sortType {
        case .listeningDateNewestFirst:
            return album.tracks.sorted {
                ($0.timeLastPlayed ?? .distantPast ) >
                ($1.timeLastPlayed ?? .distantPast)
            }
        case .listeningDateOldestFirst:
            return album.tracks.sorted {
                ($0.timeLastPlayed ?? .distantPast) <
                    ($1.timeLastPlayed ?? .distantPast)
            }
        case .playCountMostFirst:
            return album.tracks.sorted {
                $0.timesPlayed > $1.timesPlayed
            }
        case .playCountLeastFirst:
            return album.tracks.sorted {
                $0.timesPlayed < $1.timesPlayed
            }
        case .titleAscending:
            return album.tracks.sorted {
                ($0.title ?? "") < ($1.title ?? "")
            }
        case .titleDescending:
            return album.tracks.sorted {
                ($0.title ?? "") > ($1.title ?? "")
            }
        case .durationShortestFirst:
            return album.tracks.sorted {
                $0.duration < $1.duration
            }
        case .durationLongestFirst:
            return album.tracks.sorted {
                $0.duration > $1.duration
            }
        case .releaseDate:
            return album.tracks.sorted {
                ($0.releaseDate ?? .distantPast ) >
                ($1.releaseDate ?? .distantPast)
            }
        }
    }
    
    init(
        album: Album) {
        self.album = album
        self.releaseDate = album.releaseDate ?? .now
    }
}

enum TrackSortType: String, CaseIterable {
    case listeningDateNewestFirst
    case listeningDateOldestFirst
    case playCountMostFirst
    case playCountLeastFirst
    case titleAscending
    case titleDescending
    case durationShortestFirst
    case durationLongestFirst
    case releaseDate
}
