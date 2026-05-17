//
//  HomeScreenView.swift
//  Racoon
//
//  Created by Александр Переславцев on 01.04.2026.
//

import SwiftUI

///Корневой экран
struct HomeScreenView: View {
    @Environment(ViewModel.self) private var viewModel: ViewModel
//    @Environment(PlaybackManager.self) private var playbackManager : PlaybackManager
    @State private var isMiniPlayerHidden = false

    var body: some View {
        NavigationStack{
            ZStack(alignment: .top) {
                HomeScreenTopView()
                    .zIndex(1)
                ScrollView{
                    HomeScreenRecentGridView()
                    
                    HorizontalCardsSection(title: "Recent Albums", data: viewModel.albums) { album in
                        NavigationLink {
                            AlbumView(album: album)
                        } label: {
                            CardView(imageURL: album.cover, title: album.title, subTitle: album.artists.first?.name)
                        }
                    }
                    
                    HorizontalCardsSection(title: "Recent Artists", data: viewModel.artists) { artist in
                        NavigationLink {
                            ArtistView(artist: artist)
//                            ArtistView(artist: artist)
                        } label: {
                            CardView(imageURL: artist.cover, title: artist.name)
                        }
                    }
                    Spacer()
                }
                .scrollIndicators(.hidden)
                .padding(.top, 50)
            }
            .background(.blackBackground)
        }
        .navigationTitle(Text("Home Screen"))
//        .safeAreaInset(edge: .bottom) {
//            PlaybackView()
//        }
        .onPreferenceChange(MiniPlayerHiddenKey.self) { hidden in
            isMiniPlayerHidden = hidden
        }
        .overlay(alignment: .bottom) {
            if /*playbackManager.currentTrack != nil && */!isMiniPlayerHidden {
                PlaybackView()
            }
        }
    }
}





#Preview {
    let viewModel = ViewModel()
    let playbackManager = PlaybackManager()
    HomeScreenView()
        .environment(viewModel)
        .environment(playbackManager)
}
