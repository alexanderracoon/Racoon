//
//  TrackSettingsView.swift
//  Racoon
//
//  Created by Александр Переславцев on 09.05.2026.
//

import SwiftUI


struct TrackSettingsView: View {
    @Environment(ViewModel.self) private var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    let track: Track

    var body: some View {
        VStack{
            Button("Delete Track") {
                viewModel.deleteTrack(track)
                dismiss()
            }
            Button("Заглушка") {
            }
        }
        
        Button("Dismiss") {
            dismiss()
        }
    }
}
