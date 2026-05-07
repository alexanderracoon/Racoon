//
//  GenreSelectionView.swift
//  Racoon
//
//  Created by Александр Переславцев on 03.05.2026.
//

import SwiftUI

///Меню выбора жанров
struct GenreSelectionView: View {
//    @Environment(ViewModel.self) private var viewModel

    @Binding var selectedGenreIDs: Set<UUID>
    @State private var isShowingAddGenre: Bool = false
    @State private var isSelected: Bool = false
    @State var genres: [Genre]
    var action: (_ id: UUID?) -> Void
    
    private let collumns: [GridItem] = [GridItem(.adaptive(minimum: 80, maximum: .infinity), spacing: 30)]
    
    var body: some View {
//        LazyVGrid(columns: collumns,alignment: .leading, spacing: 20) {
        ScrollView(.horizontal) {
            HStack{
                ForEach(genres, id: \.id) { genre in
                    GenreSelectionButtonView(
                        title: genre.name,
                        isSelected: selectedGenreIDs.contains(where: { $0 == genre.id} )
                    ) {
                        action(genre.id)
//                        toggleGenre(genre.id)
                    }
                }
            }
        }
//        }
    }
//    private func toggleGenre(_ id: UUID?) {
//        if let id = id {
//            if selectedGenreIDs.contains(id) {
//                selectedGenreIDs.remove(id)
//            } else {
//                selectedGenreIDs.insert(id)
//            }
//        } else {
//            print("Toggle genre with nil id")
//        }
//    }
}

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
                .background(isSelected ? .green : Color.gray.opacity(0.4))
                .foregroundStyle(isSelected ? .black : .white)
                .clipShape(Capsule())
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
