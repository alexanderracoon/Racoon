import SwiftUI

///Вью для Drag & Drop музыкального файла
struct AudioDropView: View {
    @Binding var audioData: Data?
    @State var isTargeted: Bool = false
    
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [15]))
                .overlay(Text("Drop Music File"))
        }
        .frame(maxWidth: .infinity, maxHeight: 70)
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

