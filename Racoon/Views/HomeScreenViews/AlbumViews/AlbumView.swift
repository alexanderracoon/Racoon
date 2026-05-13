//
//  AlbumView.swift
//  Racoon
//
//  Created by Александр Переславцев on 06.05.2026.
//

import SwiftUI

///Экран с альбомом
struct AlbumView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(ViewModel.self) private var viewModel: ViewModel
    @Environment(PlaybackManager.self) private var playbackManager : PlaybackManager
    
    let album: Album
    let title: String
    var coverURL: URL? {album.cover}
    let artistName: String
    //MARK: - Проверить
    var tracks: [Track] {
        album.tracks.sorted {
            ($0.timeAdded ?? .distantPast) > ($1.timeAdded ?? .distantPast)
        }
    }
    @State private var selectedTrack: Track?
    
    @State private var scrollY: CGFloat = 0
    private var startpoint: CGFloat = 290
    private var distance: CGFloat = 30
    private var topBarOpacity: Double {
        let result = (scrollY - startpoint)/distance
        return Double(min(max(result, 0), 1))
    }
    
    init(album: Album) {
        self.album = album
        if let title = album.title { self.title = title } else {
            self.title = "Blank Title "
        }
        if let artistName = album.artists.first?.name { self.artistName = artistName } else {
            self.artistName = "Blank Artist Name"
        }
    }
    
    var body: some View {
        ZStack(alignment: .top){
            ScrollView {
                VStack(spacing: 0) {
                    ImageFromData(url: coverURL)
                    
                    Text("Title - \(title)")
                    Text("Artist Name - \(artistName)")
                    LazyVStack(spacing: 0) {
                        ForEach(tracks) { track in
                            TrackViewInList(
                                title: track.title,
                                artist: track.artists.first?.name,
                                imageURL: track.cover) {
                                    Button {
                                        //MARK: - переделать
                                        //playbackManager.play(track: track)
                                        print("Хе-хе")
                                        selectedTrack = track
                                    } label: {
                                        Image(systemName: "ellipsis")
                                            .foregroundStyle(.white)
                                            .clipShape(Rectangle())
                                    }
                                }
                                .onTapGesture {
                                    print("Ха-ха")
                                    print(track.artists.first?.name ?? "Blank Name")
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
                    .listStyle(.plain)
                    .background(.grayBackground)
                    //MARK: - Bug, нужна проверка album.artists.first?.albumsSorted или убрать поциональность
                    HorizontalCardsSection(title: "\(artistName): Другие альбомы", data: album.artists.first?.albumsSorted ?? []) { albums in
                        NavigationLink {
                            AlbumView(album: album)
                        } label: {
                            CardView(imageURL: album.cover, title: album.title, subTitle: album.artists.first?.name)
                        }
                    }
                }
                .padding(.top, 60)
            }
            .onScrollGeometryChange(for: CGFloat.self) { geometry in
                geometry.contentOffset.y
            } action: { oldValue, newValue in
                print("\(oldValue)  -  \(newValue)")
                print(topBarOpacity)
                scrollY = max(0, newValue)
            }
        
            topBarView
        }
        .ignoresSafeArea(edges: .top)
//        .toolbar(.hidden, for: .navigationBar)
        .toolbarBackground(.hidden, for: .navigationBar)
        .ignoresSafeArea(edges: .top)
        .background(.grayBackground)
    }
    
    
    
    var topBarView: some View {
        
        Rectangle()
            .fill(.blackBackground.opacity(topBarOpacity))
            .frame(height: 100)
            .overlay(alignment: .center) {
                Text(album.title ?? "Album")
                    .opacity(topBarOpacity)
                    .foregroundStyle(.white)
//                    .padding(.horizontal, 16)
                    .padding(.top, 50)
            }
    }
}




#Preview {
//    AlbumView()
}
