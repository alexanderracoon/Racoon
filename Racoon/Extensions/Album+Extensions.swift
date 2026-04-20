//
//  Album+Extensions.swift
//  Racoon
//
//  Created by Александр Переславцев on 20.04.2026.
//

import Foundation

extension Album {
    
    var artists: Set<Artist> {
        get { (artists_ as? Set<Artist>) ?? [] }
        set { artists_ = newValue as NSSet }
    }
    
    func addToArtists(_ value: Artist) { self.addToArtists_(value) }
    
    func addToTracks(_ value: Track) { self.addToTracks_(value) }
}
