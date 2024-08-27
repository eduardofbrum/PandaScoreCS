public struct Match: Decodable, Identifiable {
    public let id: Int
    public let status: MatchStatus
    public let scheduledAt: String?
    
    public let league: League
    public let opponents: [Opponent]?
    public let serie: Serie
    
    enum CodingKeys: String, CodingKey {
        case id, status, league, opponents, serie
        case scheduledAt = "scheduled_at"
    }
    
    public init(
        id: Int,
        status: MatchStatus,
        scheduledAt: String?,
        league: League,
        opponents: [Opponent]?,
        serie: Serie
    ) {
        self.id = id
        self.status = status
        self.scheduledAt = scheduledAt
        self.league = league
        self.opponents = opponents
        self.serie = serie
    }
}

public enum MatchStatus: String, Codable {
    case notStarted = "not_started"
    case running
    case finished
    case canceled
    case postponed
}

public struct League: Decodable {
    public let name: String
    public let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image_url"
    }
    
    public init(name: String, imageUrl: String?) {
        self.name = name
        self.imageUrl = imageUrl
    }
}

public struct Opponent: Decodable {
    let opponent: Team
    let type: String
}

public struct Team: Decodable {
    let id: Int
    let name: String
    let imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageUrl = "image_url"
    }
}

public struct Serie: Decodable {
    public let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
    
    public init(name: String) {
        self.name = name
    }
}

public extension Match {
    static func fixture(
        id: Int = 1,
        status: MatchStatus = .notStarted,
        scheduleAt: String? = "",
        league: League = .init(name: "League name", imageUrl: ""),
        opponents: [Opponent]? = [],
        serie: Serie = .init(name: "Serie name")
    ) -> Self {
        .init(
            id: id,
            status: status,
            scheduledAt: scheduleAt,
            league: league,
            opponents: opponents,
            serie: serie
        )
    }
}
