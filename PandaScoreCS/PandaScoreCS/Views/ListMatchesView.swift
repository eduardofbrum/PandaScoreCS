import SwiftUI

struct ListMatchesView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: MatchViewModel = MatchViewModel(service: MatchService())
    
    var body: some View {
        ZStack {
            Tokens.colors.background.ignoresSafeArea()
            switch viewModel.listState {
            case .loading:
                ProgressView()
            case .loaded(let matches):
                ScrollView {
                    VStack {
                        ForEach(matches) { match in
                            MatchCard(status: match.status.rawValue, opponents: [], imageLeague: match.league.imageUrl, leagueSeries: "\(match.league.name) \(match.serie.name)")
                                .padding(.bottom)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Partidas")
        .task {
            viewModel.fetchMatches()
        }
    }
}

#Preview {
    ListMatchesView()
}
