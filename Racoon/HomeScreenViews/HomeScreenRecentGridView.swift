//
//  HomeScreenRecentGridView.swift
//  Racoon
//
//  Created by Александр Переславцев on 03.04.2026.
//

import SwiftUI

struct HomeScreenRecentGridView: View {
    var gridItems = ["Favorite", "History", "New Album", "New EP", "New Single", "New Podcast"]
    var body: some View {
        VStack(){
            Grid(horizontalSpacing: 0) {
                ForEach(0..<gridItems.count / 2, id: \.self) { item in
                    GridRow {
                        Button {
                            print(gridItems[item])
                        } label: {
                            HStack(spacing:5) {
                                
                                Image("SH2AlbumCover")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 45, height: 45)
                                    .clipped()
                                    .cornerRadius(5)
                                
                                Text(gridItems[item])
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                
                                Spacer()
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.mainGray)
                            )
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 5))
                        
                        Button {
                            print(gridItems[item + 3])
                        } label: {
                            HStack(spacing: 5) {
                                Image("SH2AlbumCover")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 45, height: 45)
                                    .clipped()
                                    .cornerRadius(5)
                                
                                Text(gridItems[item + 3])
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                
                                Spacer()
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.mainGray)
                            )
                        }
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 10))
                    }
                }
            }
        }
        .padding(.top, 0)
        
    }
}
