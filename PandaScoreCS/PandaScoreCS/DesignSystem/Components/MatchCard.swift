import SwiftUI

struct MatchCard: View {
    var status: MatchStatus
    var opponents: [Opponent]?
    var imageLeague: String?
    var leagueSeries: String
    
    var body: some View {
        VStack {
            MatchTime(date: "AGORA", status: status)
            
            TeamsContainer(
                team1: opponents?.first?.opponent,
                team2: opponents?.last?.opponent
            )
            
            Divider()
                .padding(.bottom, Tokens.paddings.m)
            
            LeagueContainer(imageUrl: imageLeague, name: leagueSeries)
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .background(Tokens.colors.background2)
        .cornerRadius(16)
    }
}

#Preview {
    MatchCard(status: .running, opponents: [], imageLeague: "", leagueSeries: "")
}
