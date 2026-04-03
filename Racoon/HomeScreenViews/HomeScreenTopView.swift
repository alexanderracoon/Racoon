//
//  HomeScreenTopView.swift
//  Racoon
//
//  Created by Александр Переславцев on 03.04.2026.
//

import SwiftUI

struct HomeScreenTopView: View {
    var body: some View {
        HStack {
            Image("Ava")
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            Button {
                
            } label: {
                Text("All")
                    .font(.system(size: 14))
                    .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    .background(.green)
                    .cornerRadius(15)
            }
            Button {
                
            } label: {
                Text("Musics")
                    .font(.system(size: 14))
                    .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    .background(.green)
                    .cornerRadius(15)
            }
            Button {
                
            } label: {
                Text("Podcasts")
                    .font(.system(size: 14))
                    .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    .background(.green)
                    .cornerRadius(15)
                
            }
        }
        .foregroundColor(.black)
        .padding(.leading, 10)
    }
}
