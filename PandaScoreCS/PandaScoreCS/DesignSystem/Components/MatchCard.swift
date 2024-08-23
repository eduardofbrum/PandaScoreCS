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
            
            
            HStack {
                VStack {
                    ImageLogo(imageUrl: opponents?.first?.opponent.imageUrl)
                        .frame(width: 60)
                        .padding(.bottom, 10)
                    Text(opponents?.first?.opponent.name ?? "Time 1")
                        .font(.system(size: 10))
                }
                
                Text("vs")
                    .font(.system(size: 12))
                    .foregroundStyle(Tokens.colors.neutral1)
                    .padding(.horizontal, 20)
                
                VStack {
                    ImageLogo(imageUrl: opponents?.last?.opponent.imageUrl)
                        .frame(width: 60)
                        .padding(.bottom, 10)
                    Text(opponents?.last?.opponent.name ?? "Time 2")
                        .font(.system(size: 10))
                }
            }
            .padding(.vertical, 18.5)
            
            Divider()
                .padding(.bottom, 8)
            
            HStack {
                HStack {
                    ImageLogo(imageUrl: imageLeague)
                        .frame(width: 16)
                        .padding(.trailing, 3.5)
                    Text(leagueSeries)
                        .font(.system(size: 8))
                }
                
                Spacer()
            }
            .padding(.bottom, 8)
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .background(Tokens.colors.background2)
        .cornerRadius(16)
    }
}

#Preview {
    MatchCard(status: "", opponents: [], imageLeague: "", leagueSeries: "")
}
