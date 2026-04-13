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
        set {
            self.audioFormat = newValue.rawValue
        }
    }
    
    var artistsSet: Set<Artist> {
        get {            
            (artists as? Set<Artist>) ?? []
        }
        set {
            artists = newValue as NSSet
        }
    }
    
    var genresSet: Set<Genre> {
        get {
            (genres as? Set<Genre>) ?? []
        }
        set {
            genres = newValue as NSSet
        }
    }
}

