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
        ScrollView(.horizontal, showsIndicators: false) {
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
    }
}
