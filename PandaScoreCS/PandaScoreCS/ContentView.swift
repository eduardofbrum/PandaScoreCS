import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    
    init() {
        UINavigationBar.appearance().barTintColor = UIColor(Tokens.colors.background)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.white)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.white)]
    }
    
    var body: some View {
        ZStack {
            Tokens.colors.background.ignoresSafeArea()
            if isActive {
                CoordinatorView()
            } else {
                SplashScreenView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
