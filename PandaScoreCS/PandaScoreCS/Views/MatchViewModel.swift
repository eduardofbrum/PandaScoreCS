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
            match1.scheduledAt < match2.scheduledAt
        }
    }
}

extension MatchViewModel {
    func formatMatchDate(dateString: String, fromFormat: String) -> String {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = fromFormat
        
        dateFormatter.dateFormat = fromFormat
        guard let date = dateFormatter.date(from: dateString) else {
            return "TBD"
        }
        
        return dateFormatter.string(from: date)
        
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        
//        guard let date = dateFormatter.date(from: dateString) else {
//            return "TBD"
//        }
//        
//        dateFormatter.locale = Locale.current
//        
//        if Calendar.current.isDateInToday(date) {
//            dateFormatter.dateFormat = "'Hoje,' HH:mm"
//        } else if Calendar.current.isDate(date, equalTo: Date(), toGranularity: .weekOfYear) {
//            dateFormatter.setLocalizedDateFormatFromTemplate("EEE HH:mm")
//        } else {
//            dateFormatter.setLocalizedDateFormatFromTemplate("dd MMMM HH:mm")
//        }
        
//        return dateFormatter.string(from: date)
    }
}
