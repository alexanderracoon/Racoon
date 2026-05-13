//
//  GenreSelectionButtonView.swift
//  Racoon
//
//  Created by Александр Переславцев on 09.05.2026.
//
import SwiftUI

///Кнопка выбора жанров
struct GenreSelectionButtonView: View {
    let title: String?
    let isSelected: Bool
    let action: () -> Void
    
    init(title: String?, isSelected: Bool = true, _ action: @escaping () -> Void = { }) {
        self.title = title
        self.isSelected = isSelected
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title ?? "Genre")
                .font(.subheadline)
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .fixedSize()
                .background(
                    Capsule()
                        .fill(isSelected ? .green : Color.gray.opacity(0.4))
                )
                .foregroundStyle(isSelected ? .black : .white)
        }
        .buttonStyle(.plain)
    }
}


#Preview {
//    GenreSelectionView()
    GenreSelectionButtonView(title: "Title", isSelected: true)
    GenreSelectionButtonView(title: "Title2", isSelected: false)
    GenreSelectionButtonView(title: "Title3")
}
