import SwiftUI

struct ImagePlayer: View {
    let imageUrl: String?

    var body: some View {
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: Tokens.sizeComponents.mediumPlayerImage.width,
                        height: Tokens.sizeComponents.mediumPlayerImage.height
                    )
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Tokens.colors.neutral1)
                    .frame(
                        width: Tokens.sizeComponents.mediumPlayerImage.width,
                        height: Tokens.sizeComponents.mediumPlayerImage.height
                    )
            }
        } else {
            RoundedRectangle(cornerRadius: 8)
                .fill(Tokens.colors.neutral1)
                .frame(
                    width: Tokens.sizeComponents.mediumPlayerImage.width,
                    height: Tokens.sizeComponents.mediumPlayerImage.height
                )
        }
    }
}

#Preview {
    ImagePlayer(imageUrl: "")
}
