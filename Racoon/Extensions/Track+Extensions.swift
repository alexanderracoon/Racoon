//
//  s.swift
//  Racoon
//
//  Created by Александр Переславцев on 09.04.2026.
//

import Foundation

extension Track {
    var format: AudioFormat {
        get {
            AudioFormat(rawValue: self.audioFormat ?? AudioFormat.mp3.rawValue) ?? .mp3
        }
        set { self.audioFormat = newValue.rawValue }
    }
    
    var artists: Set<Artist> {
        get { (artists_ as? Set<Artist>) ?? [] }
        set { artists_ = newValue as NSSet }
    }
    
    var genres: Set<Genre> {
        get { (genres_ as? Set<Genre>) ?? [] }
        set { genres_ = newValue as NSSet }
    }
    
    func addToGenres(_ value: Genre) { self.addToGenres_(value) }
    
    func addToArtists(_ value: Artist) { self.addToArtists_(value) }
}

