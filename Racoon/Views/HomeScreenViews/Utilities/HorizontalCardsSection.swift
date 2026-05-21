//
//  HorizontalCardsSection.swift
//  Racoon
//
//  Created by Александр Переславцев on 09.05.2026.
//

import SwiftUI

///Горизонтальная коллекция альбомов/артистов/карточек
struct HorizontalCardsSection<Data: RandomAccessCollection, Content: View>: View where Data.Element : Identifiable {
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
                }
                .padding(.horizontal, 10)
            }
        }
        .foregroundStyle(.white)
    }
}
