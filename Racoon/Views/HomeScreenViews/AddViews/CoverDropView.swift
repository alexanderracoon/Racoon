//
//  CoverDropView.swift
//  Racoon
//
//  Created by Александр Переславцев on 07.05.2026.
//
import SwiftUI

struct CoverDropView: View {
    @Binding var coverData: Data?
    @State var isTargeted: Bool = false
    
    var body: some View {
        VStack{
            if let uiImage = UIImage(data: coverData ?? Data()) {
                Image(uiImage: uiImage)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            else {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [15]))
                    .overlay(Text("Drop photo"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1, contentMode: .fill)
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .foregroundStyle(.white)
        .contentShape(Rectangle())
        .dropDestination(for: Data.self) { items, _ in
            guard let data = items.first else { return false }
            coverData = data
            return true
        } isTargeted: { isTargeted in
            self.isTargeted = isTargeted
        }
    }
}
