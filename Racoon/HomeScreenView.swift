//
//  HomeScreenView.swift
//  Racoon
//
//  Created by Александр Переславцев on 01.04.2026.
//

import SwiftUI

struct HomeScreenView: View {
    var gridItems = ["Favorite", "History", "New Album", "New EP", "New Single", "New Podcast"]
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("Ava")
                    .frame(width: 40, height: 40)
                Text("My Library")
                    .font(Font.largeTitle.bold())
                    .foregroundStyle(.white)
            }
            .padding(.leading, 10)
        
            HStack {
                Button {
                    
                } label: {
                    Text("All")
                        .font(.system(size: 14))
                        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                Button {
                    
                } label: {
                    Text("Musics")
                        .font(.system(size: 14))
                        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
                Button {
                    
                } label: {
                    Text("Podcasts")
                        .font(.system(size: 14))
                        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
            }
            .padding(.leading, 10)

            VStack(){
                Grid(horizontalSpacing: 0) {
                    ForEach(0..<gridItems.count / 2, id: \.self) { item in
                        GridRow {
                            Button {
                                print(gridItems[item])
                            } label: {
                                HStack(spacing: 8) {
                                    
                                    Image("SH2AlbumCover")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipped()
                                        .cornerRadius(4)
                                    
                                    Text(gridItems[item])
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                    
                                    Spacer() // чтобы текст не тянулся
                                }
                                .padding(0)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.mainGray)
                                )
                            }
                            .padding(.horizontal, 10)
                            
                            Button {
                                print(gridItems[item + 3])
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundStyle(.mainGray)
//                                        Image("SH2AlbumCover")
                                    // MARK: - Временное
                                    Text(gridItems[item + gridItems.count / 2])
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                                            
                                }
                            }
                            .aspectRatio(4, contentMode: .fit)
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 10))
                        }
                    }
                }
            }
            .padding(.top, 0)
            
            
            VStack{
                Text("Recent Albums")
                    .font(Font.title.bold())
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(0..<5, id: \.self) { _ in
                            AlbumCardView()
                                .aspectRatio(3/4, contentMode: .fit)
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .foregroundStyle(.white)
            
            VStack{
                Text("Recent Artists")
                    .font(Font.title.bold())
                    
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(0..<5, id: \.self) { _ in
                            ArtistCardView()
                                .aspectRatio(3/4, contentMode: .fit)

                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .foregroundStyle(.white)
            
            Spacer()
        }
        .background(Color.gray)
    }
}

        


struct AlbumCardView: View {
    let albumImageName: String = "SH2AlbumCover"
    let albumName: String = "Silent Hill 2 OST"
    let author: String = "Akira Yamaoka"
    
    var body: some View {
        VStack {
            Image(albumImageName)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
//                .frame(width: 150, height: 150)
//                                .overlay(Text("❤️"), alignment: .center)
            Text(albumName)
                
                .lineLimit(1)
            Text(author)
                .lineLimit(1)
        }
    }
}

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

#Preview {
    HomeScreenView()
}
