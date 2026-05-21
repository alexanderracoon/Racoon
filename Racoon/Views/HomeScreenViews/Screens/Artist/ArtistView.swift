//
//  ArtistView.swift
//  Racoon
//
//  Created by Александр Переславцев on 09.05.2026.
//

import SwiftUI

///Экран с артистом
struct ArtistView: View {
    @Environment(ViewModel.self) private var viewModel: ViewModel
    @Environment(PlaybackManager.self) private var playbackManager : PlaybackManager

    var artist: Artist
    var albums: [Album] {
        artist.albumsSorted
    }
    var tracks: [Track] {
        artist.tracks.sorted {
            ($0.timeAdded ?? .distantPast) > ($1.timeAdded ?? .distantPast)
        }
    }
    @State private var selectedTrack: Track?

    var proxy = CoverProxy()
    var body: some View {
        ScrollView{
            ImageFromData(proxy: proxy, url: artist.cover)
                .frame(maxWidth: 250, maxHeight: 250)
            
            LazyVStack {
                ForEach(tracks) { track in
                    TrackViewInList(proxy: proxy, title: track.title, artist: artist.name, imageURL: track.cover) {
                        Button {
                            selectedTrack = track
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.white)
                        }
                    }
                    .onTapGesture {
                        playbackManager.play(track: track)
                    }
                    .background(.grayBackground)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .sheet(item: $selectedTrack) {
                    print("OnDismissed")
                } content: { track in
                    TrackSettingsView(track: track)
                }
            }
            
            HorizontalCardsSection(title: "\(artist.name ?? "Исполнитель"): альбомы", data: albums) { album in
                NavigationLink {
                    AlbumView(album: album)
                } label: {
                    CardView(imageURL: album.cover, title: album.title, subTitle: artist.name)
                }
                
            }
        }
        .background(.grayBackground)
    }
}
