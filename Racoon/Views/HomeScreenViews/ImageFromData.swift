//
//  ImageFromData.swift
//  Racoon
//
//  Created by Александр Переславцев on 09.05.2026.
//
import SwiftUI

///Асинхронная картинка
/// ### Кейсы
///
///case .success показывает загруженную картинку
///
///case .failure показывает картинку Meteora и печатает ошибку
///
struct ImageFromData: View {
    enum LoadState {
        case success(UIImage)
        case failure
    }
    
    let proxy: CoverProxy
    let url: URL?
    @State private var state: LoadState = .failure
    @State private var image: UIImage?
    @State private var isLoading: Bool = false
    
    @ViewBuilder
    var coverImage: some View {
        switch state {
        case .success(let uiImage):
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
        case .failure:
            Image(.meteoraCover)
                .resizable()
                .scaledToFill()
        }
    }
    
    var body: some View {
        coverImage
            .clipped()
            .cornerRadius(5)
            .task {
                await loadImage()
            }
    }
    
    private func loadImage() async {
        guard let url else {
            await MainActor.run {
                state = .failure
            }
            return
        }
        do {
            let uiImage = try await proxy.loadData(url: url)
            
            guard !Task.isCancelled else { return }
            
            await MainActor.run {
                state = .success(uiImage)
            }
        } catch {
            
            guard !Task.isCancelled else { return }
            
            await MainActor.run {
                state = .failure
            }
            
            print("Image from data error: " ,error.localizedDescription)
        }
    }
}


//                        .scaledToFill()
//                        .aspectRatio(1, contentMode: .fill)
//                        .frame(maxWidth: 150, maxHeight: 150)
//                        .clipped()
//                        .cornerRadius(5)
//                        .padding(10)
