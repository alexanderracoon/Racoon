//
//  TrackProgressView.swift
//  Racoon
//
//  Created by Александр Переславцев on 30.04.2026.
//
import SwiftUI

///Пррогресс проигрывания песни
struct TrackProgressView: View {
    //MARK: - Заглушка
    var duration: Double = 100
    var currentTime: Double = 70
    //MARK: - Из ViewModel
    var progress: CGFloat = 0
    
    var body: some View {
        HStack(alignment: .bottom){
            GeometryReader { geometry in
                if duration > 0 {
                    let scale: CGFloat = currentTime/duration
                    ZStack(alignment: .leading) {
                        Capsule()
                            .foregroundStyle(.gray)
                        Capsule()
                            .foregroundStyle(
                                LinearGradient(colors: [.blue, .cyan], startPoint: .leading, endPoint: .trailing)
                            )
                            .frame(width: geometry.size.width *
                                   ( scale <= 1 ? scale : 0.9 ) )
                            .animation(.easeInOut(duration: 0.5), value: currentTime)
                    }
                    .frame(maxWidth: geometry.size.width, maxHeight: 5)
                }
            }
        }
            .frame(maxWidth: .infinity, maxHeight: 5)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}
