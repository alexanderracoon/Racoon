import SwiftUI

///Вью для Drag & Drop музыкального файла
struct AudioDropView: View {
    @Binding var audioData: Data?
    @State var isTargeted: Bool = false
    
    var body: some View {
        VStack{
            if let _ = audioData {
                Image(systemName: "music.note")
                    .resizable()
                    .scaledToFill()
//                    .frame(maxWidth: 200, maxHeight: 200)
                    .clipShape (RoundedRectangle(cornerRadius: 16))
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [15]))
//                    .frame(maxWidth: .infinity, maxHeight: 70)
                    .overlay(Text("Drop Music File"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 70)
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .foregroundStyle(.white)
        .contentShape(Rectangle())
        .dropDestination(for: Data.self) { items, _ in
            guard let data = items.first else { return false }
            audioData = data
            return true
        } isTargeted: { isTargeted in
            self.isTargeted = isTargeted
        }
    }
}

