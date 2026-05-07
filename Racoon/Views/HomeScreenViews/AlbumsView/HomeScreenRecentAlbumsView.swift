//
//  HomeScreenRecentAlbumsView.swift
//  Racoon
//
//  Created by Александр Переславцев on 03.04.2026.
//

import SwiftUI

///Карусель из альбомов на главном экране
struct HomeScreenRecentAlbumsView: View {
    @Environment(ViewModel.self) private var viewModel: ViewModel

    var body: some View {
        VStack{
            Text("Recent Albums")
                .font(Font.title.bold())
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.albums, id: \.self) { album in
                        NavigationLink {
                            AlbumView(album: album)
                        } label: {
                            AlbumCardView(albumImageURL: album.cover, albumTitle: album.title, authorName: album.artists.first?.name)
                                .aspectRatio(3/4, contentMode: .fill)

                        }

//                        AlbumCardView(albumImageURL: album.cover, albumTitle: album.title, authorName: album.artists.first?.name)
//                            .aspectRatio(3/4, contentMode: .fill)
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .foregroundStyle(.white)
    }
}
