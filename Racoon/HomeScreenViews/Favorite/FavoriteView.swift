    //
    //  FavoriteView.swift
    //  Racoon
    //
    //  Created by Александр Переславцев on 20.04.2026.
    //

    import SwiftUI


struct FavoriteView : View {
    @Environment(ViewModel.self) private var viewModel: ViewModel
    @Environment(PlaybackManager.self) private var playbackManager : PlaybackManager
    
    var body: some View {
        VStack(alignment: .leading){
//            Button ("Add Track") {
//                viewModel.createTrack(title: "New Track 2 ", duration: 100, audioFormat: .mp3, isDownloaded: true, isFavourite: true, timeAdded: Date(), timeLastPlayed: Date(), timesPlayed: 10, albumName: "New Album 2", artistName: "New Artist 2", genreName: "New Genre 2")
//            }

            Text("Favourites")
                .font(Font.largeTitle.bold())
                .foregroundStyle(.white)
                .padding(.leading, 10)
            Text("\(viewModel.tracks.count)")
                .foregroundStyle(.white)
                .padding(.leading, 10)
            List{
                ForEach(viewModel.tracks) { track in
                    TrackViewInList(title: track.title ?? "Untitled", artist: track.artists.first?.name ?? "Blank Artist", imageURL: track.cover) {
                        Button {
                            playbackManager.play(track: track)
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.white)
                        }
                    }
                    
                    //                    .onTapGesture {
                    //                        print("Tap \(track.title ?? "Untitled")")
                    //                        playbackManager.play(track: track)
                    //                    }
                    
                    .background(.mainGray)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }.onDelete { IndexSet in
                    viewModel.deleteTrack(indexSet: IndexSet)
                }
            }
            
            .listStyle(.plain)
            .background(.mainGray)
            
            //            NavigationLink(destination: EmptyView()) {
            //                Text("Empty")
            //            }
            .safeAreaInset(edge: .bottom) {
                PlaybackView()
            }
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddTrackView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem {
                    Button ("Add Track") {
                        viewModel.createTrack(title: "New Track 2 ", duration: 100, audioFormat: .mp3, trackCoverData: Data(), isDownloaded: true, isFavourite: true, timeAdded: Date(), timeLastPlayed: Date(), timesPlayed: 10, trackData: Data(), albumName: "New Album 2", artistName: "New Artist 2", genreName: "New Genre 2")
                    }
                }
            }
        }
        .background(.mainGray)
    }
}

#Preview {
    let viewModel = ViewModel()
    let playbackManager = PlaybackManager()
    NavigationStack{
        FavoriteView()
    }
    .environment(viewModel)
    .environment(playbackManager)
}

    // Image(systemName: "forward.frame")
    // Image(systemName: "forward.frame.fill")
    // Image(systemName: "backward.frame.fill")
