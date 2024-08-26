import SwiftUI
enum Page: Hashable {
    case listMatches
    case detailMatch(viewModel: MatchViewModel)
    
    var id: String {
        switch self {
        case .listMatches:
            "ListMatches"
        case .detailMatch:
            "DetailMatch"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Page, rhs: Page) -> Bool {
        lhs.id == rhs.id
    }
}
