//
//  HomeScreenRecentAlbumsView.swift
//  Racoon
//
//  Created by Александр Переславцев on 03.04.2026.
//

import SwiftUI

struct HomeScreenRecentAlbumsView: View {
    var body: some View {
        VStack{
            Text("Recent Albums")
                .font(Font.title.bold())
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(0..<5, id: \.self) { _ in
                        AlbumCardView()
                            .aspectRatio(3/4, contentMode: .fit)
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .foregroundStyle(.white)
    }
}
