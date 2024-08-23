import SwiftUI

struct MatchCard: View {
    var status: String
    var opponents: [Opponent]?
    var imageLeague: String?
    var leagueSeries: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(status)
                    .font(Tokens.fonts.bold8)
                    .foregroundStyle(Tokens.colors.primaryText)
                    .padding(8)
                    .background(Tokens.colors.neutral3)
                    .clipShape(
                        .rect(
                            bottomLeadingRadius: 20
                        )
                    )
            }
            
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
    MatchCard(status: "", opponents: [], imageLeague: "", leagueSeries: "")
}
