//
//  TrackViewInList.swift
//  Racoon
//
//  Created by Александр Переславцев on 21.04.2026.
//

import SwiftUI


struct TrackViewInList<ActionButtonsView>: View where ActionButtonsView: View {
    @ViewBuilder var actionButtonsView: () -> ActionButtonsView
    
    init(title trackTitle: String, artist artistName: String,actionButtonsView: @escaping () -> ActionButtonsView = { EmptyView() } ) {
        self.actionButtonsView = actionButtonsView
        self.trackTitle = trackTitle
        self.artistName = artistName
    }
    
    var trackTitle: String = "Title"
    var artistName: String = "Artist"
    
    var body: some View {
        HStack {
            Image(.sh2AlbumCover)
                .resizable()
//                .frame(width: 45, height: 45)
                .scaledToFill()
                .frame(maxWidth: 45, maxHeight: 45)
                .clipped()
                .cornerRadius(5)
                .padding(10)
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

