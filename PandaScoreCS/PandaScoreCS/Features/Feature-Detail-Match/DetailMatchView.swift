import SwiftUI

struct DetailMatchView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    var match: Match
    @ObservedObject var viewModel: DetailMatchViewModel
    
    init(match: Match, viewModel: DetailMatchViewModel) {
        self.match = match
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Tokens.colors.background.ignoresSafeArea()
            switch viewModel.detailState {
            case .loading:
                ProgressView()
                    .controlSize(.large)
            case .loaded(let playersTeam1, let playersTeam2):
                VStack(spacing: .zero) {
                    TeamsContainer(
                        team1: match.opponents?.first?.opponent,
                        team2: match.opponents?.last?.opponent
                    )
                    .padding(.vertical, Tokens.paddings.xxl)
                    
                    Text(viewModel.matchDate)
                        .font(Tokens.fonts.mediumBold)
                    
                    PlayersContainer(
                        playersTeam1: playersTeam1,
                        playersTeam2: playersTeam2
                    )
                    .padding(.vertical, Tokens.paddings.xxl)
                    Spacer()
                }
            case .error:
                Text("Erro inesperado")
            }
        }
        .task {
            viewModel.fetchMatch(match)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("\(match.league.name) \(match.serie.name)")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    coordinator.pop()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundStyle(Tokens.colors.primaryText)
                }
            }
        }
    }
}
