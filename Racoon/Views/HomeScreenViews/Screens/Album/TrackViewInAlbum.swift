//
//  TrackViewInAlbum.swift
//  Racoon
//
//  Created by Александр Переславцев on 22.05.2026.
//

import SwiftUI

///Вью с названием, именем артиста у трека, без картинки.
struct TrackViewInAlbum<ActionButtonsView: View>: View {
    let actionButtonsView: ActionButtonsView
    var trackTitle: String = "Title"
    var artistName: String = "Artist"
    
    init(
        title trackTitle: String?,
        artist artistName: String?,
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
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(trackTitle)
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                Text(artistName)
                    .font(.system(size: 20))
                    .foregroundStyle(.lightGrayText)
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
            Spacer()
            actionButtonsView
        }
        .contentShape(Rectangle())
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}
