//
//  CreateAlbumView.swift
//  Racoon
//
//  Created by Александр Переславцев on 25.04.2026.
//

import SwiftUI

struct CreateAlbumView: View {
    @Environment(ViewModel.self) private var viewModel: ViewModel

    struct AlbumBlankForm {
        var cover: Image = Image(.sh2AlbumCover)
        var releaseDate: Date = .now
        var title: String = "Blank Album"
        var artists: [Artist] = []
        var tracks: [Track] = []
    }
    
    @State var form = AlbumBlankForm()
    
    var body: some View {
        Form {
            
            TextField("Title", text: $form.title)
            DatePicker("Release Date", selection: $form.releaseDate, displayedComponents: .date)
            
//            Picker(selection: $form. ) {
//                ForEach(1...100, id: \.self) {
//                    Text("Album \($0)")
//                }
//            }
        }
    }
}

//    import UniformTypeIdentifiers

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
        .dropDestination(for: Data.self) { items, location in
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
        let folder = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("images")
        
        try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        
        let fileURL = folder.appendingPathComponent("\(UUID().uuidString).jpg")
        
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Save error:", error)
            return nil
        }
    }
}

#Preview {
    VStack {
        ImageDropView()
    }
    
}
