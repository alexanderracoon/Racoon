//
//  HomeScreenView.swift
//  Racoon
//
//  Created by Александр Переславцев on 01.04.2026.
//

import SwiftUI

struct HomeScreenView: View {
    
    var body: some View {
        NavigationStack{
            VStack {
                
                HomeScreenTopView()
                
                HomeScreenRecentGridView()
                
                HomeScreenRecentAlbumsView()
//                    .aspectRatio(1.9, contentMode: .fit)
                
                HomeScreenRecentArtistsView()
                
                    .foregroundStyle(.blue)
                
                Spacer()
            }
            .background(Color.black)
        }
        .navigationTitle(Text("Home Screen"))
        .safeAreaInset(edge: .bottom) {
            PlaybackView()
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
