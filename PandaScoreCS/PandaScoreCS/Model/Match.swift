struct Match: Decodable, Identifiable {
    let id: Int
    let status: String
    let scheduledAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case status = "status"
        case scheduledAt = "scheduled_at"
    }
}
