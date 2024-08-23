import Combine
import Foundation

enum ListState {
    case loading
    case loaded([Match])
}

class MatchViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    let service: MatchServiceProtocol
    
    @Published var listState: ListState = .loading
    
    init(service: MatchServiceProtocol) {
        self.service = service
    }
    
    func fetchMatches() {
        service.getMatches()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { data in
            }, receiveValue: {[weak self] data in
                self?.listState = .loaded(data)
            }).store(in: &cancellables)
    }
}
