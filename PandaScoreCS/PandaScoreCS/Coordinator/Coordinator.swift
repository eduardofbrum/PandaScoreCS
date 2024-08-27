import SwiftUI

class Coordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    
    init() { }
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    @MainActor
    func build(page: Page) -> some View {
        ZStack {
            switch page {
            case .listMatches(let viewModel):
                ListMatchesView(viewModel: viewModel)
            case .detailMatch(let match, let viewModel):
                DetailMatchView(match: match, viewModel: viewModel)
            }
        }
    }
}
