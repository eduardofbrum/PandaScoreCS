import SwiftUI

struct ListMatchesView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: ListMatchViewModel //= ListMatchViewModel(service: ListMatchService())
    
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
                                date: viewModel.getMatchDate(status: match.status, date: match.scheduledAt ?? ""),
                                opponents: match.opponents,
                                imageLeague: match.league.imageUrl,
                                leagueSeries: "\(match.league.name) \(match.serie.name)"
                            )
                            .padding(.bottom)
                            .onTapGesture {
                                coordinator.push(.detailMatch(
                                    match: match,
                                    viewModel: .init(
                                        service: DetailMatchService(),
                                        matchDate: match.scheduledAt ?? ""
                                    )
                                ))
                            }
                        }
                    }
                    .padding()
                }
            case .error:
                Text("Erro inesperado")
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
    @StateObject var viewModel: ListMatchViewModel = ListMatchViewModel(service: ListMatchServiceMock())
    return ListMatchesView(viewModel: viewModel)
}
