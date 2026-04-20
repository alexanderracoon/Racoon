//
//  HomeScreenRecentGridView.swift
//  Racoon
//
//  Created by Александр Переславцев on 03.04.2026.
//

import SwiftUI


struct HomeScreenRecentGridView: View {
//    var gridItems = ["Favorite", "History", "New Album", "New EP", "New Single", "New Podcast"]
    
    var gridItems = HomeScreenDestination.allCases
    var collumns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)]
    
    var body: some View {
        LazyVGrid(columns: collumns/*, spacing: 10*/) {
            ForEach(gridItems, id: \.self) { item in
                NavigationLink {
                    FavoriteView()
//                    destinationView(for: item)
                }
//                {
//
//                }
//                Button {
//                    print(item)
//                }
                label: {
                    HStack(spacing:5) {
                        Image("SH2AlbumCover")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 45, maxHeight: 45)
//                                    .frame(width: 45, height: 45)
                            .clipped()
                            .cornerRadius(5)
                        
                        Text(item.rawValue)
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
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
        }
    }
    
    @ViewBuilder
    func destinationView(for item: HomeScreenDestination) -> some View {
//        Text(item)
        switch item {
        case .favorite:
            FavoriteView()
//            FavoriteView()
//        case: .playList(let album):
//            PlaylistView(album: album)
//        default:
        case .history:
            Text(item.rawValue)
        case .newAlbum:
            Text(item.rawValue)
        case .newEP:
            Text(item.rawValue)
        case .newSingle:
            Text(item.rawValue)
        case .newPodcast:
            Text(item.rawValue)
//        case .newPodcast2:
//            Text(item.rawValue)
        }
    }
    
    enum HomeScreenDestination: String, CaseIterable {
        case favorite = "Favorite"
        case history = "History"
        case newAlbum = "New Album"
        case newEP = "New EP"
        case newSingle = "New Single"
        case newPodcast = "New Podcast"
//        case newPodcast2 = "New Podcast2"

    }
}

struct FavoriteView : View {
    @Environment(ViewModel.self) private var viewModel: ViewModel
    var body: some View {
        Button ("Add Track") {
            viewModel.createTrack(title: "New Track", duration: 100, audioFormat: .mp3, isDownloaded: true, isFavourite: true, timeAdded: Date(), timeLastPlayed: Date(), timesPlayed: 10, albumName: "New Album", artistName: "New Artist", genreName: "New Genre")
        }
        
        List(viewModel.tracks) { track in
            Text(track.title ?? "Default Track Title")
        }
        NavigationLink(destination: EmptyView()) {
            Text("Empty")
        }
    }
}

#Preview {
    HomeScreenRecentGridView(/*gridItems: ["Favorite", "History", "New Album", "New EP", "New Single", "New Podcast"]*/)
        .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
        .background(.green.opacity(0.8))
}

