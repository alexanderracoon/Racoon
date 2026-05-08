//
//  AddTrackView.swift
//  Racoon
//
//  Created by Александр Переславцев on 20.04.2026.
//

import SwiftUI

///Экран создания трека
struct AddTrackView: View {
    @Environment(ViewModel.self) private var viewModel: ViewModel

    @State private var form = TrackDTO()
    @State private var photo: Image = Image(systemName: "photo")
    @State private var isTargeted: Bool = false
    @State private var isTargetedMusic: Bool = false
    @State private var isPresented: Bool = false
    @State private var selectedGenreIDs: Set<UUID> = []
    
    var body: some View {
        VStack{
            VStack{
                CoverDropView(coverData: $form.trackCoverData)
                if let _ = form.trackData { } else {
                    AudioDropView(audioData: $form.trackData)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .foregroundStyle(.white)
            
//            GenreSelectionView(selectedGenreIDs: $selectedGenreIDs, genres: viewModel.genres) { id in
//                print("Yes")
//                toggleGenre(id)
//            }
//            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            Form {
//                Section {
//                    CoverDropView(coverData: $form.trackCoverData)
//                    AudioDropView(audioData: $form.trackData)
//                }
//                .listRowBackground(Color.trackCreationSectionBackground)
                Section("Основное") {
                    TextField(text: $form.title, prompt: Text("Название").foregroundStyle(.grayText)) {
                        Text("Xexe")
                    }
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
                .foregroundStyle(.white)
                .listRowBackground(Color.trackCreationSectionBackground)
                
                Section("Время") {
                    DatePicker("Дата добавления", selection: $form.timeAdded, displayedComponents: [.date, .hourAndMinute])
                    DatePicker("Дата выхода", selection: $form.releaseDate, displayedComponents: [.date])
                        .tint(.white)
                    DatePicker("Последнее прослушивание", selection: $form.timeLastPlayed, displayedComponents: [.date, .hourAndMinute])
                        .tint(.white)
                        .foregroundStyle(.white)
                    LabeledContent {
                        TextField("", value: $form.timesPlayed, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(.white)
                    } label: {
                        Text("Сколько раз проиграно")
                    }
                }
                .listRowBackground(Color.trackCreationSectionBackground)
                
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
                    GenreSelectionView(selectedGenreIDs: $selectedGenreIDs,
                                       genres: viewModel.genres)
                    { id in
                        print("Yes")
                        toggleGenre(id)
                    }
                    TextField("Жанр", text: $form.genreName)
                }
                .listRowBackground(Color.trackCreationSectionBackground)
            }
            .scrollContentBackground(.hidden)
            .background(Color.grayBackground)
            .tint(.white)
            .toolbar(){
                Button("Создать трэк") {
                    createTrack(trackData: Data())
                }
            }
        }
        .preferredColorScheme(.dark)
        .background(.grayBackground)
        .navigationTitle(form.title)
        .hideMiniPlayer()
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
    var releaseDate: Date = .now
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
