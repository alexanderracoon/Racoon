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
            VStack{
                if let uiImage = UIImage(data: form.artistCoverData ?? Data()) {
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
                form.artistCoverData = data
                return true
            } isTargeted: { isTargeted in
                self.isTargeted = isTargeted
            }
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
            //        .background(.mainGray)
            .toolbar(){
                Button("Создать артиста") {
                    createArtist(ArtistData: Data())
                }
            }
        }
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
