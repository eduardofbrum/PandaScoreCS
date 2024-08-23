import SwiftUI

struct LeagueContainer: View {
    var imageUrl: String?
    var name: String
    
    var body: some View {
        HStack {
            HStack {
                ImageLogo(imageUrl: imageUrl)
                    .frame(
                        width: Tokens.sizeComponents.smallLogo.width,
                        height: Tokens.sizeComponents.smallLogo.height
                    )
                    .padding(.trailing, 3.5)
                Text(name)
                    .font(Tokens.fonts.regular8)
            }
            
            Spacer()
        }
        .padding(.bottom, Tokens.paddings.m)
        .padding(.horizontal, Tokens.paddings.xl)
    }
}

#Preview {
    LeagueContainer(imageUrl: "", name: "")
}
