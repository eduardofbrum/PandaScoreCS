import Combine
import Foundation

enum DetailState {
    case loading
    case loaded([Player], [Player])
}

class DetailMatchViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    let service: DetailMatchServiceProtocol
    
    @Published var detailState: DetailState = .loading
    
    init(service: DetailMatchServiceProtocol) {
        self.service = service
    }
    
    func fetchMatch(_ match: Match) {
        guard let team1 = match.opponents?.first else { return }
        guard let team2 = match.opponents?.last else { return }
        
        let team1Publisher = service.getMatchPlayers(teamId: team1.opponent.id)
        let team2Publisher = service.getMatchPlayers(teamId: team2.opponent.id)
        
        Publishers.Zip(team1Publisher, team2Publisher)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { response in
                },
                receiveValue: { [weak self] (team1, team2) in
                    self?.detailState = .loaded(team1, team2)
                }
            )
            .store(in: &cancellables)
    }
}
