import SwiftUI

struct TeamsContainer: View {
    var team1: Team?
    var team2: Team?
    
    var body: some View {
        HStack(spacing: .zero) {
            VStack(spacing: .zero) {
                ImageLogo(imageUrl: team1?.imageUrl)
                    .frame(
                        width: Tokens.sizeComponents.mediumLogo.width,
                        height: Tokens.sizeComponents.mediumLogo.height
                    )
                    .padding(.bottom, Tokens.paddings.l)
                Text(team1?.name ?? "TBD")
                    .font(Tokens.fonts.regular10)
            }
            
            Text("VS")
                .font(Tokens.fonts.medium)
                .foregroundStyle(Tokens.colors.neutral1)
                .padding(.horizontal, Tokens.paddings.xxl)
            
            VStack(spacing: .zero) {
                ImageLogo(imageUrl: team2?.imageUrl)
                    .frame(
                        width: Tokens.sizeComponents.mediumLogo.width,
                        height: Tokens.sizeComponents.mediumLogo.height
                    )
                    .padding(.bottom, Tokens.paddings.l)
                Text(team2?.name ?? "TBD")
                    .font(Tokens.fonts.regular10)
            }
        }
    }
}

#Preview {
    TeamsContainer()
}
