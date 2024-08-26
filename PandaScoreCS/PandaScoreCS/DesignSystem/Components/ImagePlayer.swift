import SwiftUI

struct ImagePlayer: View {
    let imageUrl: String?

    var body: some View {
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Rectangle()
                    .fill(Tokens.colors.neutral1)
            }
        } else {
            RoundedRectangle(cornerRadius: 8)
                .fill(Tokens.colors.neutral1)
        }
    }
}

#Preview {
    ImagePlayer(imageUrl: "")
}
