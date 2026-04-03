//
//  AlbumCardView.swift
//  Racoon
//
//  Created by Александр Переславцев on 03.04.2026.
//

import SwiftUI

struct AlbumCardView: View {
    let albumImageName: String = "SH2AlbumCover"
    let albumName: String = "Silent Hill 2 OST"
    let author: String = "Akira Yamaoka"
    
    var body: some View {
        VStack {
            Image(albumImageName)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
//                .frame(width: 150, height: 150)
//                .overlay(Text("❤️"), alignment: .center)
            Text(albumName)
                
                .lineLimit(1)
            Text(author)
                .lineLimit(1)
                .foregroundStyle(.grayText)
        }
    }
}
