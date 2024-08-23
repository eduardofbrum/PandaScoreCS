struct Match: Decodable, Identifiable {
    let id: Int
    let status: String
    let scheduledAt: String
    
    let league: League
    let opponents: [Opponent]?
    let serie: Serie
    
    enum CodingKeys: String, CodingKey {
        case id, status, league, opponents, serie
        case scheduledAt = "scheduled_at"
    }
}

struct League: Decodable {
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image_url"
    }
}

struct Opponent: Decodable {
    let opponent: Team
    let type: String
}

struct Team: Decodable {
    let id: Int
    let name: String
    let imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageUrl = "image_url"
    }
}

struct Serie: Decodable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}
