import SwiftUI

struct DetailMatchView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        VStack {
            Text("Detail match")
            Button("See detail") {
                coordinator.pop()
            }
        }
    }
}

#Preview {
    DetailMatchView()
}
