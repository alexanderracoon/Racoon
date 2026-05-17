//
//  PlaybackManager.swift
//  Racoon
//
//  Created by Александр Переславцев on 18.04.2026.
//

import Foundation
import SwiftUI

///ViewModel для проигрываемого трека
@Observable
class PlaybackManager {
    var currentTime: Double = 0
    var duration: Double = 100
    var isPlaying: Bool = true
    var backgroundColor: Color = .black
    
    var progress: Double {
        guard duration > 0 else { return 0 }
        return min(currentTime / duration, 1)
    }
    
    private let player = AudioEnginePlayer()
    private var progressTimer: Timer?
    
    var currentTrack: Track? {
        didSet {
            updateColor()
        }
    }


    //MARK: - Player
    ///Запуск нового трека
    func play(track: Track) {
        if currentTrack == track {
            print("Play - \(track.title ?? "Unknown track")")
            playPause()
            return
        }
        
        currentTrack = track
        currentTime = 0
        isPlaying = true
        
        guard let url = track.fileURL else {
            return print("track.fileURL is nil")
        }
        
        print(url)
        player.play(new: url)
        duration = player.duration(url: url) ?? 0
        startProgressTimer()
    }

    
    func resume() { player.play() }
    
    func pause() { player.pause() }
    
    //MARK: - Playback
    func playPause() {
        print("Play/Pause \(currentTrack?.title ?? "Unknown track")")
        if currentTrack == nil { return }
        if isPlaying {
            pause()
            stopProgressTimer()
        } else {
            resume()
            startProgressTimer()
        }
        isPlaying.toggle()
    }
    
//    var duration: Double {
//        currentTrack?.duration ?? 100
//    }
    
    
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
    
    //MARK: - Работа с таймером
    ///Создание и старт таймера  таймера
    func startProgressTimer() {
        stopProgressTimer()
        
        progressTimer = Timer.scheduledTimer(
            withTimeInterval: 0.1,
            repeats: true,
            block: { [weak self] _ in
                guard let self else { return }
                
                self.currentTime = self.player.currentTime()
                
                
                print("currentTime - \(currentTime) \n duration - \(duration) \n progress - \(progress)")
                guard self.duration > 0 else { return }

                
                if self.currentTime >= self.duration  {
                    print("PROGRESS = 1")
                    pause()
                    stopProgressTimer()
                    self.currentTime = 0
                    self.isPlaying = false
                    currentTrack = nil
                }
            }
        )
    }
    
    ///Остановка таймера
    func stopProgressTimer() {
        progressTimer?.invalidate()
        progressTimer = nil
    }
    
    //MARK: - функции для переменных
    private func updateColor() {
        guard let url = currentTrack?.cover else {
            backgroundColor = .green
            return
        }
        
        backgroundColor = ImageColorExtractor.averageColor(from: url) ?? .blue
    }
}
