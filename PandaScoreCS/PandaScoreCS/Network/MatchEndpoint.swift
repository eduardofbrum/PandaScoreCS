import Foundation

enum MatchEndpoint: APIEndpoint {
    case getMatches
    case getPlayers(teamId: Int)
    
    var baseURL: URL {
        return URL(string: "https://api.pandascore.co")!
    }
    
    var path: String {
        switch self {
        case .getMatches:
            return "/csgo/matches"
        case .getPlayers:
            return "/csgo/players"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMatches, .getPlayers:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer rZZiaoMnHUBuUmsXe6fe7dcJ0Kurs5-3W4IxXwC3N0-TWnjbVok"]
    }
    
    var parameters: [String : String]? {
        switch self {
        case .getMatches:
            return [
                "filter[opponents_filled]": "true"
            ]
        case .getPlayers(let teamId):
            return ["filter[team_id]": "\(teamId)"]
        }
    }
}
