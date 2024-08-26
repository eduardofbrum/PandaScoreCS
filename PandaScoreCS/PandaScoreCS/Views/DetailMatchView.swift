import SwiftUI

struct DetailMatchView: View {
    @EnvironmentObject var coordinator: Coordinator
    var viewModel: MatchViewModel
    
    var body: some View {
        ZStack {
            Tokens.colors.background.ignoresSafeArea()
            switch viewModel.listState {
            case .loading:
                ProgressView()
                    .controlSize(.large)
            case .loaded(let match):
                VStack {
                    TeamsContainer()
                        .padding(.vertical, Tokens.paddings.xxl)
                    Text("Hoje, 21:00")
                        .font(Tokens.fonts.mediumBold)
                    PlayersContainer()
                        .padding(.vertical, Tokens.paddings.xxl)
                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Partidas")
        .task {
            viewModel.getMatchById(1)
        }
        .refreshable {
            viewModel.fetchMatches()
        }
    }
}
