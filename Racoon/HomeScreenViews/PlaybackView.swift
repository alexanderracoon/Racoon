//
//  PlaybackView.swift
//  Racoon
//
//  Created by Александр Переславцев on 18.04.2026.
//

import SwiftUI

struct PlaybackView: View {
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.green)
                Text("Payback")
                    .foregroundStyle(Color.white)
            }
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.blue)
        }
        .aspectRatio(11/3, contentMode: .fit)
    }
}

struct TrackViewInList: View {
    var body: some View {
            
    }
}

#Preview {
    PlaybackView()
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 0)
            .foregroundStyle(.black)
            
        )
}
