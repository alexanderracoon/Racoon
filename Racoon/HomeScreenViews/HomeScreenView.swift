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
        .safeAreaInset(edge: .bottom) {
            PlaybackView()
        }
    }
}
//struct PlaybackView: View {
//    var body: some View {
//        VStack{
//            ZStack{
//                RoundedRectangle(cornerRadius: 10)
//                    .foregroundStyle(.green)
//                Text("Payback")
//                    .foregroundStyle(Color.white)
//            }
//            RoundedRectangle(cornerRadius: 10)
//                .foregroundStyle(.blue)
//        }
//        .aspectRatio(11/3, contentMode: .fit)
//    }
//}






#Preview {
    HomeScreenView()
}
