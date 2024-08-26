import SwiftUI

enum PositionCardPlayer {
    case left, right
}

struct PlayerCard: View {
    var position: PositionCardPlayer
    
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
                        Text("Nickname")
                            .font(Tokens.fonts.medium2Bold)
                        Text("Nome jogador")
                            .font(Tokens.fonts.medium)
                            .foregroundStyle(Tokens.colors.neutral4)
                    }
                    .padding(.trailing, Tokens.paddings.xl)
                    ImagePlayer(imageUrl: "")
                        .frame(
                            width: Tokens.sizeComponents.mediumPlayerImage.width,
                            height: Tokens.sizeComponents.mediumPlayerImage.height
                        )
                        .padding(.trailing, Tokens.paddings.l2)
                case .right:
                    ImagePlayer(imageUrl: "")
                        .frame(
                            width: Tokens.sizeComponents.mediumPlayerImage.width,
                            height: Tokens.sizeComponents.mediumPlayerImage.height
                        )
                        .padding(.leading, Tokens.paddings.l2)
                    
                    VStack(alignment: .leading) {
                        Text("Nickname")
                            .font(Tokens.fonts.medium2Bold)
                        Text("Nome jogador")
                            .font(Tokens.fonts.medium)
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
    PlayerCard(position: .left)
}
