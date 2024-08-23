import SwiftUI

struct TeamsContainer: View {
    var team1: Team?
    var team2: Team?
    
    var body: some View {
        HStack {
            VStack {
                ImageLogo(imageUrl: team1?.imageUrl)
                    .frame(width: 60)
                    .padding(.bottom, 10)
                Text(team1?.name ?? "TBD")
                    .font(.system(size: 10))
            }
            
            Text("vs")
                .font(.system(size: 12))
                .foregroundStyle(Tokens.colors.neutral1)
                .padding(.horizontal, 20)
            
            VStack {
                ImageLogo(imageUrl: team2?.imageUrl)
                    .frame(width: 60)
                    .padding(.bottom, 10)
                Text(team2?.name ?? "TBD")
                    .font(.system(size: 10))
            }
        }
        .padding(.vertical, 18.5)
    }
}

#Preview {
    TeamsContainer()
}
