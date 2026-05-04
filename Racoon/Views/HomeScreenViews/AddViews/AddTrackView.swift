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

    @State private var form = TrackDTO()
    @State private var photo: Image = Image(systemName: "photo")
    @State private var isTargeted: Bool = false
    @State private var isTargetedMusic: Bool = false
    @State private var isPresented: Bool = false
    @State private var selectedGenreIDs: Set<UUID> = []
    
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
        VStack{
            if let musicData = form.trackData {
//                print("musicData: \(musicData)")
                Image(systemName: "music.note")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape (RoundedRectangle(cornerRadius: 16))
            } else {
                RoundedRectangle(cornerRadius: 16)
                    . strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [15]))
                    .frame(width: 200, height: 200)
                    .overlay(Text("Drop Music File"))
            }
        }.dropDestination(for: Data.self) { items, _ in
            guard let data = items.first else { return false }
            form.trackData = data
            return true
        } isTargeted: { isTargeted in
            self.isTargetedMusic = isTargeted
        }
        
        GenreSelectionView(selectedGenreIDs: $selectedGenreIDs, genres: viewModel.genres) { id in
            print("Yes")
            toggleGenre(id)
        }
        
        Form {
            Section("Основное") {
                TextField("Название", text: $form.title)
                LabeledContent {
                    TextField("", value: $form.duration, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                } label: {
                    Text("Длительность")
                }
                
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
                LabeledContent {
                    TextField("", value: $form.timesPlayed, format: .number)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                } label: {
                    Text("Сколько раз проиграно")
                }

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
                
//                GenreSelectionView()
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
            Button("Создать трэк") {
                createTrack(trackData: Data())
            }
        }
        .navigationTitle(form.title)
//        }
    }
    
    private func toggleGenre(_ id: UUID?) {
        if let id = id {
            if selectedGenreIDs.contains(id) {
                selectedGenreIDs.remove(id)
            } else {
                selectedGenreIDs.insert(id)
            }
            
            form.genres = viewModel.checkGenres(selectedGenres: selectedGenreIDs)
            
            form.genres.forEach { genre in
                print(genre.name ?? "No name")
            }
        } else {
            print("Toggle genre with nil id")
        }
    }
    
    
    
    //MARK: - Поменять trackCoverData
    private func createTrack(trackData: Data) {
        viewModel.createTrack(form)
//        viewModel.createTrack(title: form.title, duration: form.duration, audioFormat: form.audioFormat, trackCoverData: form.trackCoverData ?? Data(), isDownloaded: form.isDownloaded, isFavourite: form.isFavourite, timeAdded: form.timeAdded, timeLastPlayed: form.timeLastPlayed, timesPlayed: form.timesPlayed, trackData: trackData, albumName: "Album Test", album: form.album, artistName: "Artist Test", artist: form.artist, genreName: "Genre Test")
    }
}

struct TrackDTO {
    var title: String = ""
    var duration: Double = 0
    var audioFormat: AudioFormat = .mp3
    var trackCoverData: Data? = nil
    var isDownloaded: Bool = true
    var isFavourite: Bool = true
    var timeAdded: Date = .now
    var timeLastPlayed: Date = .now
    var timesPlayed: Int32 = 0
    var trackData: Data? = nil
    var albumName: String = ""
    var album: Album?
    var artist: Artist?
    var artistName: String = ""
    var genreName: String = ""
    var genres: [Genre] = []
}




#Preview {
    let viewModel = ViewModel()
    AddTrackView()
        .environment(viewModel)
}
