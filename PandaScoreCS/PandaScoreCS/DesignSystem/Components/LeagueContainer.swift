import SwiftUI

struct LeagueContainer: View {
    var imageUrl: String?
    var name: String
    
    var body: some View {
        HStack(spacing: .zero) {
            HStack(spacing: .zero) {
                ImageLogo(imageUrl: imageUrl)
                    .frame(
                        width: Tokens.sizeComponents.smallLogo.width,
                        height: Tokens.sizeComponents.smallLogo.height
                    )
                    .padding(.trailing, Tokens.paddings.m)
                Text(name)
                    .font(Tokens.fonts.paragraph1)
            }
            
            Spacer()
        }
        .padding(.bottom, Tokens.paddings.m)
        .padding(.horizontal, Tokens.paddings.xl)
    }
}

#Preview {
    LeagueContainer(imageUrl: "", name: "League name series")
}
