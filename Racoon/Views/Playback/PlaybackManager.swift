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
//    var duration: Double = 100
    var currentTime: Double = 0
    //currentTrack не нужен?
    var currentTrack: Track?
    var isPlaying: Bool = true
    
    let player = AudioEnginePlayer()
    
    //MARK: - Player
    func startPlayer(url: URL?) {
        if let url = url {
            print(url)
            player.play(url: url)
        } else { print("WrongURL") }
    }
    
    /// Запуск нового трека из FavoriteView
    func play(track: Track) {
        currentTrack = track
        currentTime = 0
        isPlaying = true
        
        guard let url = track.fileURL else {
            return print("track.fileURL is nil")
        }
        
        print(url)
        player.play(url: url)
        
        startPlayer(url: track.fileURL)
        player.play()
    }
    
    func resume() { player.play() }
    
    func pause() { player.pause() }
    
    //MARK: - Playback
    
//    func play_old(track: Track) {
//        currentTrack = track
//        isPlaying = true
//        startPlayer(url: track.fileURL)
//        //MARK: Плеер
//    }
    
//    func play(track: Track) {
//        guard let url = track.fileURL else { return }
//        
//        currentTrack = track
//        
//        player.load(url: url)
//        player.play()
//        
//        isPlaying = true
//    }
    
    func playPause() {
        print("Play/Pause \(currentTrack?.title ?? "Unknown track")")
//        if duration == 0 {}
        if isPlaying {
            pause()
        } else {
            resume()
        }
        currentTime += 10
        isPlaying.toggle()
//        currentTime = { Double.random(in: 0..<100) }()
    }
    
    var duration: Double {
        currentTrack?.duration ?? 100
    }
    
    
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
