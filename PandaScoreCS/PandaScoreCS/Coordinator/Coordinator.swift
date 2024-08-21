import SwiftUI

class Coordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    
    init() { }
    
    func push() {
        
    }
    
    func pop() {
        
    }
    
    func popToRoot() {
        
    }
    
    @ViewBuilder
    @MainActor
    func build() -> some View {
        ZStack {
            
        }
    }
}
