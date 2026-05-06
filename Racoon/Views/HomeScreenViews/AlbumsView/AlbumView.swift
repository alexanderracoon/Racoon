//
//  AlbumView.swift
//  Racoon
//
//  Created by Александр Переславцев on 06.05.2026.
//

import SwiftUI

struct AlbumView: View {
    let title: String
    let coverURL: URL
    let artistName: String
    let artistCover: URL
    let tracks: [Track]
    
    init(title: String, coverURL: URL, artistName: String, artistCover: URL, tracks: [Track]) {
        self.title = title
        self.coverURL = coverURL
        self.artistName = artistName
        self.artistCover = artistCover
        self.tracks = tracks
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
//    AlbumView()
}
