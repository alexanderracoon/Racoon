//
//  AddAlbumView.swift
//  Racoon
//
//  Created by Александр Переславцев on 30.04.2026.
//

import SwiftUI

struct AddAlbumView: View {
    @Environment(ViewModel.self) private var viewModel: ViewModel
    
    @State private var form = AlbumDTO()
    @State private var isTargeted: Bool = false
    @State private var isPresented: Bool = false

    
    var body: some View {
        Text("Add Album View")
        VStack{
            if let uiImage = UIImage(data: form.albumCoverData ?? Data()) {
                Image (uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape (RoundedRectangle(cornerRadius: 16))
            }
            else {
                RoundedRectangle(cornerRadius: 16)
                    . strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [15]))
                    .frame(width: 200, height: 200)
                    .overlay(Text("Drop photo"))
            }
        }.dropDestination(for: Data.self) { items, _ in
            guard let data = items.first else { return false }
            form.albumCoverData = data
            return true
        } isTargeted: { isTargeted in
            self.isTargeted = isTargeted
        }
        
        TextField("Название", text: $form.title)

        DatePicker("Дата добавления", selection: $form.releaseDate, displayedComponents: [.date])

        Picker("Artist", selection: $form.artist) {
            Text("None").tag(nil as Artist?)
            ForEach(viewModel.artists) { artist in
                Text(artist.name ?? "No name").tag(artist)
            }
        }
        
        Picker("Track", selection: $form.track) {
            Text("None").tag(nil as Track?)
            ForEach(viewModel.tracks) { track in
                Text(track.title ?? "No title").tag(track)
            }
        }
        
    }
}

struct AlbumDTO {
    var albumCoverData: Data? = nil
    var releaseDate: Date = .now
    var title: String = ""
    //MARK: - BUG изменить на выбор одного или изменить View для выбора многих
    var artist: Artist? = nil
    var track: Track? = nil
}
