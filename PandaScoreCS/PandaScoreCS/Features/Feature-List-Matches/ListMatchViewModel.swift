import Combine
import Foundation

enum ListState {
    case loading
    case loaded([Match])
}

class ListMatchViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    let service: ListMatchServiceProtocol
    
    @Published var listState: ListState = .loading
    
    init(service: ListMatchServiceProtocol) {
        self.service = service
    }
    
    func fetchMatches() {
        service.getMatches()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { response in
            }, receiveValue: {[weak self] data in
                let matches = self?.sortMatches(data)
                guard let matches = matches else { return }
                self?.listState = .loaded(matches)
            }).store(in: &cancellables)
    }
    
    func getMatchDate(status: MatchStatus, date: String) -> String {
        switch status {
        case .running:
            return "AGORA"
        case .finished:
            return "FINALIZADO"
        default:
            return formatMatchDate(dateString: date, fromFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
        }
    }
    
    func sortMatches(_ matches: [Match]) -> [Match] {
        return matches.sorted { match1, match2 in
            if match1.status == .running && match2.status != .running {
                return true
            } else if match1.status != .running && match2.status == .running {
                return false
            }
            
            if match1.status == .finished && match2.status != .finished {
                return true
            } else if match1.status != .finished && match2.status == .finished {
                return false
            }
            
            return match1.scheduledAt ?? "3024-07-17T07:05:16Z" < match2.scheduledAt ?? "3024-07-17T07:05:16Z"
        }
    }
}
