import SwiftUI

struct PlayersContainer: View {
    var body: some View {
        HStack(spacing: 12) {
            VStack(spacing: .zero) {
                PlayerCard(position: .left)
                PlayerCard(position: .left)
                PlayerCard(position: .left)
                PlayerCard(position: .left)
                PlayerCard(position: .left)
            }
            VStack(spacing: .zero) {
                PlayerCard(position: .right)
                PlayerCard(position: .right)
                PlayerCard(position: .right)
                PlayerCard(position: .right)
                PlayerCard(position: .right)
            }
        }
    }
}

#Preview {
    PlayersContainer()
}
