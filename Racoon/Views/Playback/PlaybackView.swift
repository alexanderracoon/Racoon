//
//  PlaybackView.swift
//  Racoon
//
//  Created by Александр Переславцев on 18.04.2026.
//

import SwiftUI

struct PlaybackView: View {
    @Environment(PlaybackManager.self) private var playbackManager : PlaybackManager

    var body: some View {
        VStack(spacing: 0){
            ZStack(alignment: .bottom){
                TrackViewInList(title: playbackManager.playingTitle, artist: playbackManager.playingArtist) {
                    Button {
                        playbackManager.playPause()
                    } label: {
                        Image(systemName: "play.fill")
                            .scaledToFill()
                            .font(.system(size: 30))
                    }
                    .foregroundStyle(Color.white)
                }
                .background(.black.opacity(0.95))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                TrackProgressView(duration: playbackManager.duration, currentTime: playbackManager.currentTime)
            }
            BottomNavigationView()
//                .aspectRatio(11/3, contentMode: .fit)
        }
    }
}



struct BottomNavigationView: View {
    var body: some View {
        HStack {
            Button {} label: {
                Image(systemName: "house")
                    .scaledToFill()
                    .font(.system(size: 30))
            }
            .foregroundStyle(Color.white)
            Spacer()
            Button {} label: {
                Image(systemName: "house")
                    .scaledToFill()
                    .font(.system(size: 30))
            }
            .foregroundStyle(Color.white)
        }
        .padding(10)
//        .background()
        .background(LinearGradient(colors: [.black.opacity(0.9), .black.opacity(0.8)], startPoint: .bottom, endPoint: .top))
//        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    PlaybackView()
//        .padding(10)
        .background(RoundedRectangle(cornerRadius: 0)
            .foregroundStyle(.gray)
            
        )
}
