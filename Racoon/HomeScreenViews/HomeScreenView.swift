//
//  HomeScreenView.swift
//  Racoon
//
//  Created by Александр Переславцев on 01.04.2026.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            HomeScreenTopView()

            HomeScreenRecentGridView()
            
            HomeScreenRecentAlbumsView()
                        
            HomeScreenRecentArtistsView()
            
            Spacer()
        }
        .background(Color.black)
    }
}





#Preview {
    HomeScreenView()
}
