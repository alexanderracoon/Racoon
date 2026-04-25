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

struct TrackProgressView: View {
    //MARK: - Заглушка
    var duration: Double = 100
    var currentTime: Double = 70
    //MARK: - Из ViewModel
    var progress: CGFloat = 0
    
    var body: some View {
        HStack(alignment: .bottom){
            GeometryReader { geometry in
                if duration > 0 {
                    let scale: CGFloat = currentTime/duration
                    ZStack(alignment: .leading) {
                        Capsule()
                            .foregroundStyle(.gray)
                        Capsule()
                            .foregroundStyle(
                                LinearGradient(colors: [.blue, .cyan], startPoint: .leading, endPoint: .trailing)
                            )
                            .frame(width: geometry.size.width *
                                   ( scale <= 1 ? scale : 0.9 ) )
                            .animation(.easeInOut(duration: 0.5), value: currentTime)
                    }
                    .frame(maxWidth: geometry.size.width, maxHeight: 5)
                }
            }
        }
            .frame(maxWidth: .infinity, maxHeight: 5)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
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
