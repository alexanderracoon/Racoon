//
//  LocalMediaStorage.swift
//  Racoon
//
//  Created by Александр Переславцев on 25.04.2026.
//

import Foundation
import SwiftUI

class LocalMediaStorage {
    //MARK: - URLs
    var documentsURL: URL {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Деректория не найдена")
        }
        return url
    }
    var audioURL: URL { documentsURL.appending(path: "Audio") }
    var coversURL: URL { documentsURL.appending (path: "Covers") }
    var trackCoversURL: URL { coversURL.appending(path: "Tracks") }
    var albumCoversURL: URL { coversURL.appending(path: "Albums") }
    var artistCoversURL: URL { coversURL.appending(path: "Artists") }
    
    //MARK: - Audio
    func saveAudio(data dataFromView: Data?, trackID: UUID, format: AudioFormat) -> URL {
        createDirectoryIfNeeded(for: audioURL)
        //MARK: - Сделать проверку выше
        guard let data = dataFromView else { fatalError("Data is nil")}

        let url = audioURL.appendingPathComponent("\(trackID).\(format.rawValue)")
        print("Url to save audio: \(url.path)")
        
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
    
    //MARK: - Track Cover
    func removeTrackCover(trackID: UUID?) {
        guard let trackID = trackID else { return print("ID doesn't exist")}
        let url = trackCoversURL.appendingPathComponent ("\(trackID).jpg")
        do {
            try FileManager.default.removeItem(at: url)
            print(url.path, "Deleted")
        }
        catch {
            print(error.localizedDescription, "Error deleting file")
        }
    }
    
    func saveTrackCover(data dataFromView: Data?, trackID: UUID) -> URL {
        createDirectoryIfNeeded (for: trackCoversURL)
        //MARK: - Сделать проверку выше
        guard let data = dataFromView else { fatalError("Data is nil")}
        //MARK: поправить расширение файла
        let url = trackCoversURL.appendingPathComponent("\(trackID).jpg")
        print("Url to save track cover: \(url.path)")
        do{
            try data.write(to: url)
            print("Data saved successfully to: \(url.path)")
        }
        catch{
            print(error.localizedDescription, "Error saving file")
        }
        return url
    }
          
    //MARK: - Album Cover
    func removeAlbumCover(albumID: UUID?) {
        guard let albumID = albumID else { return print("ID doesn't exist")}
        let url = albumCoversURL.appendingPathComponent ("\(albumID).jpg")
        do {
            try FileManager.default.removeItem(at: url)
            print(url.path, "Album Cover Deleted")
        }
        catch {
            print(error.localizedDescription, "Error deleting file")
        }
    }

    func saveAlbumCover(data dataFromView: Data?, albumID: UUID) -> URL {
        createDirectoryIfNeeded (for: albumCoversURL)
        //MARK: - Сделать проверку
        guard let data = dataFromView else { fatalError("Data is nil")}

        //MARK: поправить расширение файла
        let url = albumCoversURL.appendingPathComponent("\(albumID).jpg")
        print("Url to save album cover: \(url.path)")
        do{
            try data.write(to: url)
            print("Data saved successfully to: \(url.path)")
        }
        catch{
            print(error.localizedDescription, "Error saving file")
        }
        return url
    }
    
    //MARK: - Artist Cover
    func removeArtistCover(artistID: UUID?) {
        guard let artistID = artistID else { return print("ID doesn't exist")}
        let url = artistCoversURL.appendingPathComponent ("\(artistID).jpg")
        do {
            try FileManager.default.removeItem(at: url)
            print(url.path, "Artist Cover Deleted")
        }
        catch {
            print(error.localizedDescription, "Error deleting file")
        }
    }

    func saveArtistCover(data dataFromView: Data?, artistID: UUID) -> URL {
        createDirectoryIfNeeded (for: artistCoversURL)
        //MARK: - Сделать проверку выше

        guard let data = dataFromView else { fatalError("Data is nil")}
        //MARK: поправить расширение файла
        let url = artistCoversURL.appendingPathComponent("\(artistID).jpg")
        print("Url to save artist cover: \(url.path)")
        do{
            try data.write(to: url)
            print("Data saved successfully to: \(url.path)")
        }
        catch{
            print(error.localizedDescription, "Error saving file")
        }
        return url
    }
    
    //MARK: - Utilities
    func loadImage(for url: URL) -> Data? {
        try? Data(contentsOf: url)
    }

    func createDirectoryIfNeeded (for url: URL){
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        }
    }

    //MARK: - Не нужно пока
    func deleteFile(at url: URL?) {
        guard let url else { return }
        try? FileManager.default.removeItem(at: url)
    }
}
