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
                            VStack {
                                Text("\(match.status)")
                                HStack {
                                    if let opponents = match.opponents {
                                        Text(opponents.first?.opponent.name ?? "")
                                        Text("vs")
                                        Text(opponents.last?.opponent.name ?? "")
                                    }
                                }
                                Text("\(match.league.name) \(match.serie.name)")
                            }
                            .cornerRadius(2)
                            .padding()
                            .background(.red)
                            
                        }
                    }
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
