import SwiftUI

struct ListMatchesView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        VStack {
            Text("List matches")
            Button("See detail") {
                coordinator.push(.detailMatch)
            }
        }
    }
}

#Preview {
    ListMatchesView()
}
