//
//  s.swift
//  Racoon
//
//  Created by Александр Переславцев on 09.04.2026.
//

extension Track {
    var format: AudioFormat {
        get {
            AudioFormat(rawValue: self.audioFormat ?? "MP3") ?? .mp3
        }
        set {
            self.audioFormat = newValue.rawValue
        }
    }
}
