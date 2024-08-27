import SwiftUI

struct PlayersContainer: View {
    var playersTeam1: [Player]
    var playersTeam2: [Player]
    
    var body: some View {
        GeometryReader { reader in
            HStack(alignment: .top, spacing: 12) {
                VStack(spacing: .zero) {
                    ForEach(playersTeam1) { player in
                        PlayerCard(
                            position: .left,
                            player: player
                        )
                    }
                }
                .frame(maxWidth: reader.size.width / 2)
                VStack(spacing: .zero) {
                    ForEach(playersTeam2) { player in
                        PlayerCard(
                            position: .right,
                            player: player
                        )
                    }
                }
                .frame(maxWidth: reader.size.width / 2)
            }
        }
    }
}

#Preview {
    EmptyView()
//    PlayersContainer()
}
