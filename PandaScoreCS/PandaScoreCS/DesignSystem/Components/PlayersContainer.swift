import SwiftUI

struct PlayersContainer: View {
    var body: some View {
        HStack {
            VStack {
                PlayerCard(position: .left)
                PlayerCard(position: .left)
                PlayerCard(position: .left)
                PlayerCard(position: .left)
                PlayerCard(position: .left)
            }
            VStack {
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
