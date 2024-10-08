import SwiftUI

enum PositionCardPlayer {
    case left, right
}

struct PlayerCard: View {
    var position: PositionCardPlayer
    var player: Player
    
    var body: some View {
        ZStack {
            UnevenRoundedRectangle(
                cornerRadii: position == .right ? .init(topLeading: 12, bottomLeading: 12) : .init(bottomTrailing: 12, topTrailing: 12))
                    .fill(Tokens.colors.background2)
                    .frame(height: 54)
                    .offset(y: 6)
            
            HStack(alignment: .bottom) {
                switch position {
                case .left:
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(player.nickname)
                            .font(Tokens.fonts.paragraph4Bold)
                            .lineLimit(1)
                        Text("\(player.firstName ?? "")")
                            .font(Tokens.fonts.paragraph3)
                            .foregroundStyle(Tokens.colors.neutral4)
                    }
                    .padding(.trailing, Tokens.paddings.xl)
                    ImagePlayer(imageUrl: player.imageUrl)
                        .frame(
                            width: Tokens.sizeComponents.mediumPlayerImage.width,
                            height: Tokens.sizeComponents.mediumPlayerImage.height
                        )
                        .padding(.trailing, Tokens.paddings.l2)
                case .right:
                    ImagePlayer(imageUrl: player.imageUrl)
                        .padding(.leading, Tokens.paddings.l2)
                    
                    VStack(alignment: .leading) {
                        Text(player.nickname)
                            .font(Tokens.fonts.paragraph4Bold)
                            .lineLimit(1)
                        Text("\(player.firstName ?? "")")
                            .font(Tokens.fonts.paragraph3)
                            .foregroundStyle(Tokens.colors.neutral4)
                    }
                    .padding(.leading, Tokens.paddings.xl)
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 58)
        .padding(.bottom, Tokens.paddings.l2)
    }
}

#Preview {
    let player = Player(id: 1, nickname: "FalleN", firstName: "Gabriel", lastName: "Toledo", imageUrl: "")
    return PlayerCard(position: .left, player: player)
}
