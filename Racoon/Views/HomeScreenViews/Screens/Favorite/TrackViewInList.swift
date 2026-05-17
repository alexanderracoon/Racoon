//
//  TrackViewInList.swift
//  Racoon
//
//  Created by Александр Переславцев on 21.04.2026.
//

import SwiftUI


///Вью с картинкой, названием, именем артиста у трека
struct TrackViewInList<ActionButtonsView: View>: View {
    let actionButtonsView: ActionButtonsView
    var trackTitle: String = "Title"
    var artistName: String = "Artist"
    var imageURL: URL?
    
    init(
        title trackTitle: String?,
        artist artistName: String?,
        imageURL: URL? = nil ,
        @ViewBuilder actionButtonsView: () -> ActionButtonsView = { EmptyView() } ) {
        self.actionButtonsView = actionButtonsView()
        if let trackTitle = trackTitle {
            self.trackTitle = trackTitle
        } else {
            self.trackTitle = "Blank track title"
        }
        if let artistName = artistName{
            self.artistName = artistName
        } else { self.artistName = "Blank artist name"}
        
        if let imageURL = imageURL {
            self.imageURL = imageURL
        } else { self.imageURL = nil }
    }
    
    var body: some View {
        HStack {
            ImageFromData(url: imageURL)
                .frame(maxWidth: 45, maxHeight: 45)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))

//            VStack{
//                if let url = imageURL,
//                   let data = try? Data(contentsOf: url),
//                   let uiImage = UIImage(data: data) {
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(maxWidth: 45, maxHeight: 45)
//                        .clipped()
//                        .cornerRadius(5)
//                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
//                }
//                //MARK: - Доделать или удалить
//                else {
//                    EmptyView()
////                    Image(.sh2AlbumCover)
////                        .resizable()
////                        .scaledToFill()
////                        .frame(maxWidth: 45, maxHeight: 45)
////                        .clipped()
////                        .cornerRadius(5)
////                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
//                }
//            }
            VStack(alignment: .leading) {
                Text(trackTitle)
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                Text(artistName)
                    .font(.system(size: 20))
                    .foregroundStyle(.grayText)
            }
            .padding(0)
            Spacer()
            actionButtonsView
//          .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
        }
//        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

