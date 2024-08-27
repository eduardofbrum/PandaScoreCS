import SwiftUI

struct MatchCard: View {
    var status: MatchStatus
    var date: String
    var opponents: [Opponent]?
    var imageLeague: String?
    var leagueSeries: String
    
    var body: some View {
        VStack(spacing: .zero) {
            MatchTime(date: date, status: status)
            
            TeamsContainer(
                team1: opponents?.first?.opponent,
                team2: opponents?.last?.opponent
            )
            .padding(.vertical, 18.5)
            
            Divider()
                .padding(.bottom, Tokens.paddings.m)
            
            LeagueContainer(imageUrl: imageLeague, name: leagueSeries)
        }
        .frame(maxWidth: .infinity)
        .background(Tokens.colors.background2)
        .cornerRadius(16)
    }
}

#Preview {
    MatchCard(status: .running, date: "Hoje, 20:30", opponents: [], imageLeague: "", leagueSeries: "Major League - Rio de Janeiro")
}
