//
//  PlaybackView.swift
//  Racoon
//
//  Created by Александр Переславцев on 18.04.2026.
//

import SwiftUI

struct PlaybackView: View {
    var body: some View {
        VStack(spacing: 0){
            ZStack(alignment: .bottom){
                TrackViewInList {
                    Button {} label: {
                        Image(systemName: "play.fill")
                            .scaledToFill()
                            .font(.system(size: 30))
                    }
                    .foregroundStyle(Color.white)
                }
                TrackProgressView()
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
                    }
                    .frame(maxWidth: geometry.size.width, maxHeight: 5)
                }
    //        .frame(width: .infinity, height: 5)
            }
//            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
//            .foregroundStyle(Color.white)
//            .frame(maxWidth: .infinity, maxHeight: 5)
        }
//            ZStack(alignment: .leading) {
//                Capsule()
////                RoundedRectangle(cornerRadius: 10)
//                    .foregroundStyle(.gray)
////                .opacity(0.1)
//                Capsule()
////                RoundedRectangle(cornerRadius: 10)
//                    .foregroundStyle(.white)
//                    .frame(width: 50)
////                .opacity(0.3)
//            }
//        .frame(width: .infinity, height: 5)
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

struct TrackViewInList<ActionButtonsView>: View where ActionButtonsView: View {
    @ViewBuilder var actionButtonsView: () -> ActionButtonsView
    
    init(actionButtonsView: @escaping () -> ActionButtonsView = { EmptyView() } ) {
        self.actionButtonsView = actionButtonsView
    }
    
    var body: some View {
        HStack {
            Image(.sh2AlbumCover)
                .resizable()
//                .frame(width: 45, height: 45)
                .scaledToFill()
                .frame(maxWidth: 45, maxHeight: 45)
                .clipped()
                .cornerRadius(5)
                .padding(10)
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.system(size: 20))
                Text("Artist")
                    .font(.system(size: 20))
//                track.title
//                track.artistsNames
            }
            
            .foregroundStyle(.white)
            Spacer()
            actionButtonsView()
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
        }
        .background(.black.opacity(0.95))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    PlaybackView()
//        .padding(10)
        .background(RoundedRectangle(cornerRadius: 0)
            .foregroundStyle(.gray)
            
        )
}
