//
//  AddArtistView.swift
//  Racoon
//
//  Created by Александр Переславцев on 30.04.2026.
//

import SwiftUI

///Экран создания артиста
struct AddArtistView: View {
    @Environment(ViewModel.self) private var viewModel: ViewModel
    
    //MARK: - Добавить инициализацию для значения по умолчанию и возможности передачи значений для редактирования
    @State private var form = ArtistDTO()
    @State private var isTargeted: Bool = false
    @State private var isPresented: Bool = false
    
    
    var body: some View {
        VStack {
            CoverDropView(coverData: $form.artistCoverData)
            Form {
                TextField("Название", text: $form.name)
                
                Picker("Album", selection: $form.album) {
                    Text("None").tag(nil as Album?)
                    ForEach(viewModel.albums, id: \.objectID) { album in
                        Text(album.title ?? "No title").tag(album)
                    }
                }
                
                Picker("Track", selection: $form.track) {
                    Text("None").tag(nil as Track?)
                    ForEach(viewModel.tracks) { track in
                        Text(track.title ?? "No title").tag(track)
                    }
                }
                //        }
            }
            .scrollContentBackground(.hidden)
            .background(Color.grayBackground)
            .tint(.white)
            .toolbar(){
                Button("Создать артиста") {
                    createArtist(ArtistData: Data())
                }
            }
        }
        .preferredColorScheme(.dark)
        .background(.grayBackground)
        .hideMiniPlayer()
        .navigationTitle(form.name)
    }
    func createArtist(ArtistData: Data) {
        viewModel.createArtist(form)
    }
}

struct ArtistDTO {
    var artistCoverData: Data? = nil
    var name: String = ""
    //MARK: - BUG изменить на выбор одного или изменить View для выбора многих
    var album: Album? = nil
    var track: Track? = nil
}

#Preview {
    AddArtistView()
}
