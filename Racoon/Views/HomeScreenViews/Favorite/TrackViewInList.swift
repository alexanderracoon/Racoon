//
//  TrackViewInList.swift
//  Racoon
//
//  Created by Александр Переславцев on 21.04.2026.
//

import SwiftUI


///Вью с картинкой, названием, именем артиста у трека
struct TrackViewInList<ActionButtonsView>: View where ActionButtonsView: View {
    @ViewBuilder var actionButtonsView: () -> ActionButtonsView
    
    init(title trackTitle: String?, artist artistName: String?, imageURL: URL? = nil , actionButtonsView: @escaping () -> ActionButtonsView = { EmptyView() } ) {
        self.actionButtonsView = actionButtonsView
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
    
    var trackTitle: String = "Title"
    var artistName: String = "Artist"
    var imageURL: URL?
    
    var body: some View {
        HStack {
            if let url = imageURL,
               let data = try? Data(contentsOf: url),
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
            
            VStack(alignment: .leading) {
                Text(trackTitle)
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                Text(artistName)
                    .font(.system(size: 20))
                    .foregroundStyle(.grayText)

//                track.title
//                track.artistsNames
            }
            
//            .foregroundStyle(.orange)
            Spacer()
            actionButtonsView()
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
        }
//        .background(.black.opacity(0.95))
//        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

