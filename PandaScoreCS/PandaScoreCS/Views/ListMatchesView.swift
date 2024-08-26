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
                    .controlSize(.large)
            case .loaded(let matches):
                ScrollView {
                    VStack(spacing: .zero) {
                        ForEach(matches) { match in
                            MatchCard(
                                status: match.status,
                                date: viewModel.getMatchDate(status: match.status, date: match.scheduledAt),
                                opponents: match.opponents,
                                imageLeague: match.league.imageUrl,
                                leagueSeries: "\(match.league.name) \(match.serie.name)"
                            )
                            .padding(.bottom)
                            .onTapGesture {
                                coordinator.push(.detailMatch(viewModel: viewModel))
                            }
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
        .refreshable {
            viewModel.fetchMatches()
        }
    }
}

#Preview {
    ListMatchesView()
}
