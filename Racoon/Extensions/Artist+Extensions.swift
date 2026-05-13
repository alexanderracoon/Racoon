//
//  Artist+Extensions.swift
//  Racoon
//
//  Created by Александр Переславцев on 20.04.2026.
//

import Foundation

extension Artist {
    var albums: Set<Album> {
        get { (albums_ as? Set<Album>) ?? [] }
        set { albums_ = newValue as NSSet }
    }
    ///Отсортирован по убыванию даты
    var albumsSorted: [Album] {
        albums.sorted {
            ($0.releaseDate ?? .distantPast) > ($1.releaseDate ?? .distantPast)
        }
    }
    
    var tracks: Set<Track> {
        get { (tracks_ as? Set<Track>) ?? [] }
        set { tracks_ = newValue as NSSet }
    }
    
    func addToAlbums(_ value: Album) { self.addToAlbums_(value) }
    
    func addToTracks(_ value: Track) { self.addToTracks_(value) }
    
}
