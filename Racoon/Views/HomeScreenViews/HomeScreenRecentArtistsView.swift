//
//  HomeScreenRecentArtistsView.swift
//  Racoon
//
//  Created by Александр Переславцев on 03.04.2026.
//

import SwiftUI

///Карусель недавних артистов на главном экране
struct HomeScreenRecentArtistsView : View {
    var body: some View {
        VStack{
            Text("Recent Artists")
                .font(Font.title.bold())
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(0..<5, id: \.self) { _ in
                        ArtistCardView()
//                            .aspectRatio(3/4, contentMode: .fit)
                        
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .foregroundStyle(.white)

    }
}
