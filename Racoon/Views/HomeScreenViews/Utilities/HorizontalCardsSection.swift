//
//  HorizontalCardsSection.swift
//  Racoon
//
//  Created by Александр Переславцев on 09.05.2026.
//

import SwiftUI

///Горизонтальная коллекция альбомов/артистов/карточек
struct HorizontalCardsSection<Data: RandomAccessCollection, Content: View>: View where Data.Element : Identifiable {
//    @Environment(ViewModel.self) private var viewModel: ViewModel
//    var cards: [Album] { viewModel.albums }
    var title: String = "Recent Albums"
    var data: Data
    private let content: (Data.Element) -> Content
    
    init(title: String,
         data: Data,
         @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.title = title
        self.data = data
        self.content = content
    }
    
    var body: some View {
        VStack{
            Text(title)
                .font(Font.title.bold())
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(data) { item in
                        content(item)
                    }
//                    content
//                    ForEach(albums, id: \.objectID) { album in
//                        NavigationLink {
//                            AlbumView(album: album)
//                        } label: {
//                            CardView(imageURL: album.cover, title: album.title, subTitle: album.artists.first?.name)
////                                .aspectRatio(3/4, contentMode: .fill)
//                        }
//                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .foregroundStyle(.white)
    }
}
