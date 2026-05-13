//
//  ImageFromData.swift
//  Racoon
//
//  Created by Александр Переславцев on 09.05.2026.
//
import SwiftUI

struct ImageFromData: View {
    let url: URL?
    var body: some View {
        VStack{
            if let url = url,
               let data = try? Data(contentsOf: url),
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                Image(.sh2AlbumCover)
                    .resizable()
            }
        }
        .scaledToFill()
        .frame(maxWidth: 250, maxHeight: 250)
        .clipped()
        .cornerRadius(5)
        .padding(10)
    }
}
