//
//  HomeScreenView.swift
//  Racoon
//
//  Created by Александр Переславцев on 01.04.2026.
//

import SwiftUI

///Корневой экран
struct HomeScreenView: View {
    @Environment(PlaybackManager.self) private var playbackManager : PlaybackManager
    @State private var isMiniPlayerHidden = false

    var body: some View {
        NavigationStack{
            VStack {
                
                HomeScreenTopView()
                
                HomeScreenRecentGridView()
                NavigationLink {
                    ImageDropView()
                } label: {
                    Text("Drop Image")
                }
                
                HomeScreenRecentAlbumsView()
//                    .aspectRatio(1.9, contentMode: .fit)
                
                HomeScreenRecentArtistsView()
                
                    .foregroundStyle(.blue)
                
                Spacer()
            }
//            .background(Color.black)
            .background(.backgroundBlack)
        }
        .navigationTitle(Text("Home Screen"))
//        .safeAreaInset(edge: .bottom) {
//            PlaybackView()
//        }
        .background(Color.black)
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
