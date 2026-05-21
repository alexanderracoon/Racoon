//
//  AddEntitiesView.swift
//  Racoon
//
//  Created by Александр Переславцев on 03.05.2026.
//

import SwiftUI

///Экран выбора создания сущностей
struct AddEntitiesView: View {
    var body: some View {
        VStack{
            NavigationLink("AddTrack") {
                AddTrackView()
            }
            NavigationLink("AddAlbum") {
                AddAlbumView()
            }
            NavigationLink("AddArtist") {
                AddArtistView()
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AddEntitiesView()
}
