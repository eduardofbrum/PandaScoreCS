import SwiftUI

struct ImageLogo: View {
    let imageUrl: String?

    var body: some View {
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Circle()
                    .fill(Tokens.colors.neutral1)
            }
        } else {
            Circle()
                .fill(Tokens.colors.neutral1)
        }
    }
}

#Preview {
    ImageLogo(imageUrl: "")
}
