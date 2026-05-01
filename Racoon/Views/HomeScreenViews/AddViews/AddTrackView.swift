//
//  AddTrackView.swift
//  Racoon
//
//  Created by Александр Переславцев on 20.04.2026.
//

import Foundation
import SwiftUI

struct AddTrackView: View {
    @Environment(ViewModel.self) private var viewModel: ViewModel

    struct TrackDTO {
        var title: String = ""
        var duration: String = ""
        var audioFormat: AudioFormat = .mp3
        var trackCoverData: Data? = nil
        var isDownloaded: Bool = true
        var isFavourite: Bool = true
        var timeAdded: Date = .now
        var timeLastPlayed: Date = .now
        var timesPlayed: String = ""
        var trackData: Data? = nil
        var albumName: String = ""
        var album: Album?
        var artist: Artist?
        var artistName: String = ""
        var genreName: String = ""
    }
    
    @State private var form = TrackDTO()
    @State private var prhoto: Image = Image(systemName: "photo")
    @State private var isTargeted: Bool = false
    @State private var isPresented: Bool = false
    
    var body: some View {
        //        NavigationStack {
        VStack{
            if let uiImage = UIImage(data: form.trackCoverData ?? Data()) {
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
            form.trackCoverData = data
            //MARK: - перенести из View
//            if let url = saveImage(data: data) {
//                imageURL = url
//            }
            return true
        } isTargeted: { isTargeted in
            self.isTargeted = isTargeted
        }
        
        Form {
            Section("Основное") {
                TextField("Название", text: $form.title)
                TextField("Длительность", text: $form.duration)
                    .keyboardType(.decimalPad)
                
                Picker("Формат", selection: $form.audioFormat) {
                    ForEach(AudioFormat.allCases, id: \.self) { format in
                        Text(format.rawValue).tag(format)
                    }
                }
                
                
                Toggle("Скачан", isOn: $form.isDownloaded)
                Toggle("Избранное", isOn: $form.isFavourite)
            }
            
            Section("Время") {
                DatePicker("Дата добавления", selection: $form.timeAdded, displayedComponents: [.date, .hourAndMinute])
                DatePicker("Последнее прослушивание", selection: $form.timeLastPlayed, displayedComponents: [.date, .hourAndMinute])
                TextField("Сколько раз проиграно", text: $form.timesPlayed)
                    .keyboardType(.numberPad)
            }
//            .listRowBackground(Color.mainGray)
            
            Section("Связи") {
                Picker("Album", selection: $form.album) {
                    Text("None").tag(nil as Album?)
                    ForEach(viewModel.albums, id: \.objectID) { album in
                        Text(album.title ?? "No title").tag(album)
                    }
                }
                Picker("Artist", selection: $form.artist) {
                    Text("None").tag(nil as Artist?)
                    ForEach(viewModel.artists) { artist in
                        Text(artist.name ?? "No name").tag(artist)
                    }
                }
//                TextField("Альбом", text: $form.albumName)
//                TextField("Исполнитель", text: $form.artistName)
                TextField("Жанр", text: $form.genreName)
            }
            
//            Section {
//                Button("Создать сущность") {
//                    createTrack()
//                }
//            }
        }
        .scrollContentBackground(.hidden)
//        .background(.mainGray)
        .toolbar(){
            Button("Создать сущность") {
                createTrack(trackData: Data())
            }
        }
        .navigationTitle(form.title)
//        }
    }
    
    //MARK: - Поменять trackCoverData 
    private func createTrack(trackData: Data) {
        viewModel.createTrack(title: form.title, duration: 100, audioFormat: form.audioFormat, trackCoverData: form.trackCoverData ?? Data(), isDownloaded: form.isDownloaded, isFavourite: form.isFavourite, timeAdded: form.timeAdded, timeLastPlayed: form.timeLastPlayed, timesPlayed: 0, trackData: trackData, albumName: "Album Test", album: form.album, artistName: "Artist Test", artist: form.artist, genreName: "Genre Test")
    }
}




#Preview {
    let viewModel = ViewModel()
    AddTrackView()
        .environment(viewModel)
}
