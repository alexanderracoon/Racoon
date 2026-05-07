//
//  ImageDropView.swift
//  Racoon
//
//  Created by Александр Переславцев on 06.05.2026.
//

import SwiftUI

///Тест для картинки
struct ImageDropView: View {
    @State private var imageURL: URL?
    @State private var isTargeted = false

    var body: some View {
        
        VStack {
            if let url = imageURL,
               let data = try? Data(contentsOf: url),
               let uiImage = UIImage(data: data) {
                
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 240, height: 240)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8]))
                    .frame(width: 240, height: 240)
                    .overlay(Text("Drop photo"))
            }
        }
        .dropDestination(for: Data.self) { items, _  in
            guard let data = items.first else { return false }
            
            if let url = saveImage(data: data) {
                imageURL = url
            }
            
            return true
        } isTargeted: { isTargeted in
            self.isTargeted = isTargeted
        }
    }
    
    func saveImage(data: Data) -> URL? {
        let localStorage = LocalMediaStorage()
        return localStorage.saveImage(data: data)
    }
}
