//
//  AlbumView.swift
//  Racoon
//
//  Created by Александр Переславцев on 06.05.2026.
//

import SwiftUI

///Экран с альбомом
struct AlbumView: View {
//    @Environment(ViewModel.self) private var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(PlaybackManager.self) private var playbackManager: PlaybackManager
    @State private var albumViewModel: AlbumViewModel
    @State private var selectedTrack: Track?
    init(album: Album) {
        self._albumViewModel = State(initialValue: AlbumViewModel(album: album))
    }

    //MARK: - Управление прозрачностью
    @State private var scrollY: CGFloat = 0
    private var startpoint: CGFloat = 290
    private var distance: CGFloat = 30
    private var topBarOpacity: Double {
        let result = (scrollY - startpoint)/distance
        return Double(min(max(result, 0), 1))
    }
    
    //MARK: - добавить кеш, дорогая операция
//    private var colorFromImage: Color {
//        ImageColorExtractor.averageColor(from: albumViewModel.coverURL) ?? .blue
//    }
    
    @State private var colorFromImage: Color = .blue
    
    var proxy = CoverProxy.shared
    
    var body: some View {
        ZStack(alignment: .top){
            ScrollView {
                VStack(spacing: 0) {
                    albumHeader
                    albumTracks
                    relatedAlbumsSection
                }
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
        .toolbarBackground(.hidden, for: .navigationBar)
        .ignoresSafeArea(edges: .top)
        .background(.grayBackground)
        .task {
            colorFromImage = ImageColorExtractor
                .averageColor(from: albumViewModel.coverURL) ?? .blue
        }
    }
    
    var albumHeader: some View {
        ZStack(alignment: .bottom){
            Rectangle()
                .foregroundStyle(colorFromImage)
                .overlay {
                    LinearGradient(colors: [.grayBackground, .grayBackground.opacity(0.4)], startPoint: .bottom, endPoint: .top)
                }
            VStack{
                ImageFromData(proxy: proxy, url: albumViewModel.coverURL)
                    .frame(maxWidth: 250, maxHeight: 250)
                Text("Title - \(albumViewModel.title)")
                Text("Artist Name - \(albumViewModel.artistName)")
            }
            .foregroundStyle(.white)
            .padding(.top, 60)
        }
        .ignoresSafeArea(edges: .top)
    }
    
    var albumTracks: some View {
        LazyVStack(spacing: 0) {
            ForEach(albumViewModel.tracks) { track in
                TrackViewInAlbum(title: track.title, artist: albumViewModel.artistName) {
                    Button {
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
                //MARK: - Лишний модификатор?
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
        .sheet(item: $selectedTrack) {
            print("OnDismissed")
        } content: { track in
            TrackSettingsView(track: track)
        }
        //MARK: - Добавить отмену асинхронной операции -
        //ВОзможно хорошей идеей будет сделать задачу как @State
        .onDisappear() {
            print("Test")
        }
        
        .listStyle(.plain)
        .background(.grayBackground)
    }
    
    var relatedAlbumsSection: some View {
        ForEach(albumViewModel.artists) { artist in
            HorizontalCardsSection(
                title: "\(artist.name ?? "Blank Artist"): Другие альбомы",
                data: artist.albumsSorted
            ) { album in
                NavigationLink {
                    AlbumView(album: album)
                } label: {
                    CardView(imageURL: album.cover,
                             title: album.title,
                             subTitle: album.artists.first?.name
                    )
                }
            }
        }
    }
    
    var topBarView: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [colorFromImage, .grayBackground],
                    startPoint: .top, endPoint: .bottom
                )
            )
            .opacity(topBarOpacity)
            .frame(height: 100)
            .overlay(alignment: .center) {
                Text(albumViewModel.title)
                    .opacity(topBarOpacity)
                    .foregroundStyle(.white)
                    .padding(.top, 50)
            }
    }
}


#Preview {
//    AlbumView()
}
