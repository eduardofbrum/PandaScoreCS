import SwiftUI

struct MatchTime: View {
    var date: String
    var status: MatchStatus = .notStarted
    
    var body: some View {
        HStack(spacing: .zero) {
            Spacer()
            Text(date)
                .font(Tokens.fonts.paragraph1Bold)
                .foregroundStyle(Tokens.colors.primaryText)
                .padding(Tokens.paddings.m)
                .background(status == .running ? Tokens.colors.alert : Tokens.colors.neutral3)
                .clipShape(
                    .rect(
                        bottomLeadingRadius: 20
                    )
                )
        }
    }
}

#Preview {
    MatchTime(date: "Hoje, 20:30")
}
