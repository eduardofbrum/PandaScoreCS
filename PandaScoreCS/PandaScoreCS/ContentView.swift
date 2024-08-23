import SwiftUI

struct ContentView: View {
    init() {
        UINavigationBar.appearance().barTintColor = UIColor(Tokens.colors.background)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.white)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.white)]
    }
    
    var body: some View {
        CoordinatorView()
    }
}

#Preview {
    ContentView()
}
