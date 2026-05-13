//
//  PlaybackView.swift
//  Racoon
//
//  Created by Александр Переславцев on 18.04.2026.
//

import SwiftUI

///Миниплеер снизу экрана
///
/// - Parameters:
///   - style: An instance of a type that conforms to  that
///     SwiftUI draws behind the modified view.
///   - edges: The set of edges for which to ignore safe area insets
///     Specify an empty set to respect safe area insets on all edges. 
///
/// - Returns: A view with the specified style drawn behind it.
struct PlaybackView: View {
    @Environment(PlaybackManager.self) private var playbackManager : PlaybackManager

    var body: some View {
        VStack(spacing: 0){
            ZStack(alignment: .bottom){
                TrackViewInList(title: playbackManager.playingTitle, artist: playbackManager.playingArtist, imageURL: playbackManager.playingTrackCover) {
                    Button {
                        playbackManager.playPause()
                    } label: {
                        Image(systemName: playbackManager.isPlaying ? "pause.fill" : "play.fill")
                            .scaledToFill()
                            .font(.system(size: 30))
                    }
                    .foregroundStyle(Color.white)
                }
                .background(.black.opacity(0.95))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                TrackProgressView(progress: playbackManager.progress)
//                TrackProgressView(duration: playbackManager.duration, currentTime: playbackManager.currentTime)

//                TrackProgressView(duration: playbackManager.duration, currentTime: playbackManager.currentTime)
            }
            BottomNavigationView()
//                .aspectRatio(11/3, contentMode: .fit)
        }
    }
}






#Preview {
    PlaybackView()
//        .padding(10)
        .background(RoundedRectangle(cornerRadius: 0)
            .foregroundStyle(.gray)
            
        )
}
