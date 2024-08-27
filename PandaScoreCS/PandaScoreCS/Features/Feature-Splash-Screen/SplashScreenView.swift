import SwiftUI

struct SplashScreenView: View {
    @State private var scale: CGFloat = 0.5

    var body: some View {
        Image("fuze-logo")
            .resizable()
            .scaledToFit()
            .frame(width: 113, height: 113)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.bouncy(duration: 1.5)) {
                    self.scale = 1.0
                }
            }
    }
}


#Preview {
    SplashScreenView()
}
