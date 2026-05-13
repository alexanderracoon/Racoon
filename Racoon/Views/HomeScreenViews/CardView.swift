//
//  CardView.swift
//  Racoon
//
//  Created by Александр Переславцев on 09.05.2026.
//

import SwiftUI

///Карточка с альбомом или артистом
struct CardView: View {
    let imageName: String = "SH2AlbumCover"
    
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
            VStack{
                if let url = imageURL,
                   let data = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
//                        .scaledToFill()
//                        .aspectRatio(1, contentMode: .fill)
//                        .frame(maxWidth: 150, maxHeight: 150)
//                        .clipped()
//                        .cornerRadius(5)
//                        .padding(10)
                } else {
                    Image(.sh2AlbumCover)
                        .resizable()
//                        .scaledToFill()
//                        .aspectRatio(1, contentMode: .fill)
//                        .frame(maxWidth: 150, maxHeight: 150)
//                        .clipped()
//                        .cornerRadius(5)
//                        .padding(10)
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
                    .foregroundStyle(.grayText)
            }
        }
        .aspectRatio(4/3, contentMode: .fill)
    }
}
