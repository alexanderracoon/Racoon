//
//  ArtistCardView.swift
//  Racoon
//
//  Created by Александр Переславцев on 03.04.2026.
//

import SwiftUI

struct ArtistCardView: View {
    let artistName: String = "Linkin Park"
    let artistImageName: String = "LPBand"
    
    var body: some View {
        VStack{
            Image(artistImageName)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
//                .scaledToFit()
//                .frame(width: 150, height: 150)
                .clipShape(Circle())
            Text(artistName)
        }
    }
}
