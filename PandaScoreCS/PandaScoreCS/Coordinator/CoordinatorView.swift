import SwiftUI

struct CoordinatorView: View {
    @StateObject var coordinator: Coordinator = Coordinator()
    
    var body: some View {
        ZStack {
            NavigationStack(path: $coordinator.path) {
                Group {
                    coordinator.build(page: .listMatches)
                }
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
            }
            .toolbarBackground(Tokens.colors.background, for: .navigationBar)
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    CoordinatorView()
}
