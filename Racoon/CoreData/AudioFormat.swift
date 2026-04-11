//
//  AudioFormat.swift
//  Racoon
//
//  Created by Александр Переславцев on 09.04.2026.
//

import Foundation

enum AudioFormat: String, CaseIterable, Codable {
    case mp3 = "MP3"
    case flac = "FLAC"
    case aac = "AAC"
}
