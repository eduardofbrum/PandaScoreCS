import SwiftUI

struct CoordinatorView: View {
    @StateObject var coordinator: Coordinator = Coordinator()
    
    var body: some View {
        VStack {
            NavigationStack(path: $coordinator.path) {
                Group {
                    coordinator.build(page: .listMatches)
                }
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
            }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    CoordinatorView()
}
