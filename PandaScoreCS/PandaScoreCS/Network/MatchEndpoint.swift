import Foundation

enum MatchEndpoint: APIEndpoint {
    case getMatches
    
    var baseURL: URL {
        return URL(string: "https://api.pandascore.co")!
    }
    
    var path: String {
        switch self {
        case .getMatches:
            return "/csgo/matches"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMatches:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getMatches:
            return ["Authorization": "Bearer rZZiaoMnHUBuUmsXe6fe7dcJ0Kurs5-3W4IxXwC3N0-TWnjbVok"]
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getMatches:
            return ["page": 1, "limit": 10]
        }
    }
}
