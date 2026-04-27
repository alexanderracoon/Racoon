//
//  LocalMediaStorage.swift
//  Racoon
//
//  Created by Александр Переславцев on 25.04.2026.
//

import Foundation
import SwiftUI

class LocalMediaStorage {
    
    var documentsURL: URL {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Деректория не найдена")
        }
        return url
    }
    
    var audioURL: URL { documentsURL.appending(path: "Audio") }
    
    func saveAudio(data: Data, trackID: UUID, format: AudioFormat) -> URL {
        //MARK: - Проверка на существование деректорий и т.п
        createAudioDirectoryIfNeeded()
        
        let url = audioURL.appendingPathComponent("\(trackID).\(format.rawValue)")
        print("Url to save: \(url.path)")

        do{
            try data.write(to: url)
            print("Data saved successfully to: \(url.path)")
        } catch {
            print(error.localizedDescription, "Error saving file")
        }
        
        return url
    }
    
    func removeAudio(trackID: UUID?, format: AudioFormat) {
        guard let trackID = trackID else { return print("ID doesn't exist") }
        let url = audioURL.appendingPathComponent("\(trackID).\(format.rawValue)")
        
        do {
            try FileManager.default.removeItem(at: url)
            print(url.path, "Deleted")
        } catch {
            print(error.localizedDescription, "Error deleting file")
        }
    }
    
    func loadTrackImage(track: Track) -> Data? {
        guard let id = track.id else { return nil}
        let url = audioURL.appendingPathComponent("\(id).\(track.format.rawValue)")
        return loadImage(for: url)
    }
    
    func loadImage(for url: URL) -> Data? {
        try? Data(contentsOf: url)
    }
    
    func createAudioDirectoryIfNeeded() {
        if !FileManager.default.fileExists(atPath: audioURL.path) {
            try? FileManager.default.createDirectory(at: audioURL, withIntermediateDirectories: true)
        }
    }

    //MARK: - Не нужно пока
    func deleteFile(at url: URL?) {
        guard let url else { return }
        try? FileManager.default.removeItem(at: url)
    }
    
    func saveData(data: Data) {
        let newFolderUrl: URL = documentsURL.appendingPathComponent("Audio")
        
        FileManager.default.createFile(
            atPath: newFolderUrl.path(),
            contents: data,
            attributes: [FileAttributeKey.creationDate : Date()])
    }
    
    func saveImage(data: Data) -> URL? {
        let folder = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("images")
        
        try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        
        let fileURL = folder.appendingPathComponent("\(UUID().uuidString).jpg")
        
        print(fileURL)
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Save error:", error)
            return nil
        }
    }
}
