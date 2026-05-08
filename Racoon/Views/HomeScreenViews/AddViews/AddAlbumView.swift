//
//  AddAlbumView.swift
//  Racoon
//
//  Created by Александр Переславцев on 30.04.2026.
//

import SwiftUI

///Экран создания альбома
struct AddAlbumView: View {
    @Environment(ViewModel.self) private var viewModel: ViewModel
    
    @State private var form = AlbumDTO()
    @State private var isTargeted: Bool = false
    @State private var isPresented: Bool = false

    
    var body: some View {
        VStack{
            CoverDropView(coverData: $form.albumCoverData)
            Form {
                TextField("Название", text: $form.title)
                
                DatePicker("Дата релиза", selection: $form.releaseDate, displayedComponents: [.date])
                
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
            .scrollContentBackground(.hidden)
            .background(Color.grayBackground)
            .tint(.white)
            .toolbar(){
                Button("Создать альбом") {
                    createAlbum()
                }
            }
        }
        .preferredColorScheme(.dark)
        .background(.grayBackground)
        .navigationTitle(form.title)
        .hideMiniPlayer()
    }
    
    func createAlbum() {
        viewModel.createAlbum(form)
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
