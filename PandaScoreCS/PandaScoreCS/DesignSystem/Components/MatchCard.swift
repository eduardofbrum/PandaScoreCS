import SwiftUI

struct MatchCard: View {
    var status: String
    var opponents: [String]
    var leagueSeries: String
    
    var body: some View {
        VStack {
            //vira outra view
            Text("")
            //vira outra view
            HStack {
                
            }
            
            HStack {
                Image(uiImage: UIImage())
                Text("")
            }
        }
    }
}

#Preview {
    MatchCard(status: "", opponents: [], leagueSeries: "")
}
