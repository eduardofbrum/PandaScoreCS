import Combine
import Foundation

enum ListState {
    case loading
    case loaded([Match])
}

enum DetailState {
    case loading
    case loaded(Match)
}

class MatchViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    let service: MatchServiceProtocol
    
    @Published var listState: ListState = .loading
    @Published var detailState: DetailState = .loading
    
    init(service: MatchServiceProtocol) {
        self.service = service
    }
    
    func fetchMatches() {
        service.getMatches()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { data in
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
            
            return match1.scheduledAt < match2.scheduledAt
        }
    }
    
    func getMatchById(_ id: Int) {
        service.getMatches()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { data in
            }, receiveValue: {[weak self] data in
                let matches = self?.sortMatches(data)
                guard let match = matches?.first else { return }
                self?.detailState = .loaded(match)
            }).store(in: &cancellables)
    }
}

extension MatchViewModel {
    func formatMatchDate(dateString: String, fromFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        
        guard let date = dateFormatter.date(from: dateString) else {
            return "TBD"
        }
        
        dateFormatter.locale = Locale.current
        
        if Calendar.current.isDateInToday(date) {
            dateFormatter.dateFormat = "'Hoje,' HH:mm"
        } else if Calendar.current.isDate(date, equalTo: Date(), toGranularity: .weekOfYear) {
            dateFormatter.dateFormat = "E, HH:mm"
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate.replacingOccurrences(of: ".", with: "").capitalized
        } else {
            dateFormatter.dateFormat = "dd.MM HH:mm"
        }
        
        return dateFormatter.string(from: date)
    }
}
