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

