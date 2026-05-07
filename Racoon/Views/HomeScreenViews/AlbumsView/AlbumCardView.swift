//
//  AlbumCardView.swift
//  Racoon
//
//  Created by Александр Переславцев on 03.04.2026.
//

import SwiftUI

///Карточка альбома на главном экране
struct AlbumCardView: View {
    let albumImageName: String = "SH2AlbumCover"
    let albumTitle: String
    let authorName: String
    let albumImageURL: URL
    
    init(albumImageURL: URL?, albumTitle: String?, authorName: String?) {
        //MARK: - Bug, временно. Передалть потом
        if let albumImageURL {
            self.albumImageURL = albumImageURL
        } else { self.albumImageURL = URL(string: "hehe")! }
        if let albumTitle {
            self.albumTitle = albumTitle
        } else { self.albumTitle = "Blank Title" }
        if let authorName {
            self.authorName = authorName
        } else { self.authorName = "Blank Name"}
    }
    
    var body: some View {
        VStack {
            if let data = try? Data(contentsOf: albumImageURL),
               let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                    .resizable()
//                    .scaledToFill()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(maxWidth: 150, maxHeight: 150)
                    .clipped()
//                    .cornerRadius(5)
//                    .padding(10)
            } else {
                Image(.sh2AlbumCover)
                    .resizable()
//                    .scaledToFill()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(maxWidth: 150, maxHeight: 150)
                    .clipped()
//                    .cornerRadius(5)
//                    .padding(10)
            }
//            Image(albumImageName)
//                .resizable()
//                .aspectRatio(1, contentMode: .fit)
//                .frame(width: 150, height: 150)
//                .overlay(Text("❤️"), alignment: .center)
            Text(albumTitle)
                .lineLimit(1)
            Text(authorName)
                .lineLimit(1)
                .foregroundStyle(.grayText)
        }
        .aspectRatio(4/3, contentMode: .fill)
    }
}
