//
//  CardView.swift
//  Racoon
//
//  Created by Александр Переславцев on 09.05.2026.
//

import SwiftUI

///Карточка с альбомом или артистом, асинхронная
struct CardView: View {
    let imageURL: URL?
    let title: String
    let subTitle: String?
    
    init(imageURL: URL?, title: String?, subTitle: String? = nil) {
        self.imageURL = imageURL
        
        if let title { self.title = title }
        else { self.title = "Blank Title" }
        
        self.subTitle = subTitle
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    Image(.sh2AlbumCover)
                        .resizable()
//                        .scaledToFill()
//                        .aspectRatio(1, contentMode: .fill)
//                        .frame(maxWidth: 150, maxHeight: 150)
//                        .clipped()
//                        .cornerRadius(5)
//                        .padding(10)
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
            .aspectRatio(1, contentMode: .fill)
            .frame(maxWidth: 150, maxHeight: 150)
            .clipped()
            
            Text(title)
                .lineLimit(1)
            if let subTitle = subTitle {
                Text(subTitle)
                    .lineLimit(1)
                    .foregroundStyle(.lightGrayText)
            }
        }
        .aspectRatio(4/3, contentMode: .fill)
    }
}
