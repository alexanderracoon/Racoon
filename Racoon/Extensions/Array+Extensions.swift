//
//  Array+Extensions.swift
//  Racoon
//
//  Created by Александр Переславцев on 09.05.2026.
//
import Foundation


extension Array where Element == Track {
    func sortedByTimeAddedDescending() -> [Track] {
        sorted {
            ($0.timeAdded ?? .distantPast) > ($1.timeAdded ?? .distantPast)
        }
    }
}

extension Array where Element == Album {
    func sortedByReleaseDate() -> [Album] {
        sorted {
            ($0.releaseDate ?? .distantPast) > ($1.releaseDate ?? .distantPast)
        }
    }
}
