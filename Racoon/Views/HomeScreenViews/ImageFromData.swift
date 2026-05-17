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
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                Image(.sh2AlbumCover)
                    .resizable()
            case .success(let image):
                image
                    .resizable()
            case .failure(let error):
                Image(.meteoraCover)
                    .resizable()
                    .onAppear {
                        print(error.localizedDescription)
                    }
                
            @unknown default:
                Image(systemName: "photo")
                    .resizable()
            }
        }
        .scaledToFill()
//        .frame(maxWidth: 250, maxHeight: 250)
        .clipped()
        .cornerRadius(5)
//        .padding(10)
    }
}


//                        .scaledToFill()
//                        .aspectRatio(1, contentMode: .fill)
//                        .frame(maxWidth: 150, maxHeight: 150)
//                        .clipped()
//                        .cornerRadius(5)
//                        .padding(10)
