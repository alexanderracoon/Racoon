//
//  PlaybackManager.swift
//  Racoon
//
//  Created by Александр Переславцев on 18.04.2026.
//

import Foundation

@Observable
class PlaybackManager {
//    var trackTitle = "Track Title"
//    var artistName = "Artist Name"
//    var duration: Double = 1.23
    var currentTrack: Track?
    var isPlaying: Bool = true
    

    func play(track: Track) {
        currentTrack = track
        isPlaying = true
        //MARK: Плеер
    }
    
    func playPause() {
        print("Play/Pause \(currentTrack?.title ?? "Unknown track")")
        isPlaying.toggle()
        currentTime = { Double.random(in: 0..<100) }()
    }
    
    var duration: Double {
        currentTrack?.duration ?? 100
    }
    
    var currentTime: Double = 0
    
    var playingTitle: String {
        currentTrack?.title ?? "No title"
    }
    
    var playingArtist: String {
        guard let currentTrack else { return "Unknown artist" }
        let artists = currentTrack.artists
        
        
        var artistNames = ""
        if artists.count == 0 { artistNames = "Blank author"}
        for artist in artists {
            artistNames.append(artist.name ?? "Anonymous author ")
        }
        return artistNames
    }
    
    var playingTrackCover: URL? {
        guard let currentTrack else { return nil }
        return currentTrack.cover
    }
}
