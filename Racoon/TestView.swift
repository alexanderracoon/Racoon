//
//  TestView.swift
//  Racoon
//
//  Created by Александр Переславцев on 04.04.2026.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        Text("Hello")
            .background {
                Rectangle().foregroundStyle(Color.blue)
            }
        Circle()
            .frame(width: 100, height: 100)
            .overlay(alignment: .center) {
                Rectangle().foregroundStyle(Color.blue)
                Text("I'm Circle").foregroundStyle(.white)
        }
        Text("Я круг")
            .overlay(alignment: .center) {
                Circle().foregroundStyle(.blue)
            }
        Text("Hello").overlay(alignment: .center) {
            Rectangle()
        }

    }
}

#Preview {
    TestView()
}

//// Convert NSSet to typed array for easier use
//var tracksInAlbumArray: [Track] {
//    let set = tracks as? Set<Track> ?? []
//    return set.sorted { ($0.timeAdded ?? Date()) < ($1.timeAdded ?? Date()) }
//}
