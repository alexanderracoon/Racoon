//
//  AlbumView.swift
//  Racoon
//
//  Created by Александр Переславцев on 06.05.2026.
//

import SwiftUI

///Экран с альбомом
struct AlbumView: View {
    let title: String
    let coverURL: URL
    let artistName: String
    let artistCover: URL
    let tracks: [Track]
    let album: Album
    
    init(title: String = "",
         coverURL: URL = URL.homeDirectory,
         artistName: String = "",
         artistCover: URL = URL.homeDirectory,
         tracks: [Track] = [],
         album: Album) {
        self.album = album
        if let title = album.title { self.title = title } else {
            self.title = "Blank Title "
        }
        if let coverURL = album.cover { self.coverURL = coverURL } else {
            //MARK: - Bug
            self.coverURL = URL.homeDirectory
        }
        if let artistName = album.artists.first?.name { self.artistName = artistName } else {
            self.artistName = "Blank Artist Name"
        }
        
        if let artistCover = album.artists.first?.cover { self.artistCover = artistCover } else {
            self.artistCover = URL.homeDirectory
        }
        //MARK: - Переделать
        self.tracks = album.tracks.sorted(by: { t1, t2 in
            t1.timeAdded ?? .now > t2.timeAdded ?? .now
        })
        
        var trackNames = ""
        for track in tracks {
            trackNames += track.title ?? "blank"
            trackNames += " "
        }
        print(trackNames)
        
//        self.title = album.title
//        self.coverURL = coverURL
//        self.artistName = artistName
//        self.artistCover = artistCover
//        self.tracks = tracks
    }
    
    var body: some View {
        if let data = try? Data(contentsOf: coverURL),
           let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 45, maxHeight: 45)
                .clipped()
                .cornerRadius(5)
                .padding(10)
        } else {
            Image(.sh2AlbumCover)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 45, maxHeight: 45)
                .clipped()
                .cornerRadius(5)
                .padding(10)
        }
        
        Text("Title \(title)")
        Text("Artist Name \(artistName)")
        Text("")
        //        ForEach(tracks, id: \.id) { track in
        //            Text(track.title ?? "Track Title")
        //        }
        
        ForEach(tracks) { track in
            TrackViewInList(title: track.title, artist: track.artists.first?.name, imageURL: track.cover) {
                Button {
                    print(track.artists.first?.name ?? "Blank Name")
//                     playbackManager.play(track: track)
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.white)
                }
            }
        }
    }
}



#Preview {
//    AlbumView()
}
