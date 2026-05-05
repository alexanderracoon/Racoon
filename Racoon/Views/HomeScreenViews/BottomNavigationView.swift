//
//  BottomNavigationView.swift
//  Racoon
//
//  Created by Александр Переславцев on 05.05.2026.
//
import SwiftUI

struct BottomNavigationView: View {
    var body: some View {
        HStack {
            Button {} label: {
                Image(systemName: "house")
                    .scaledToFill()
                    .font(.system(size: 30))
            }
            .foregroundStyle(Color.white)
            Spacer()
            Button {} label: {
                Image(systemName: "house")
                    .scaledToFill()
                    .font(.system(size: 30))
            }
            .foregroundStyle(Color.white)
        }
        .padding(10)
//        .background()
        .background(LinearGradient(colors: [.black.opacity(0.9), .black.opacity(0.8)], startPoint: .bottom, endPoint: .top))
//        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
