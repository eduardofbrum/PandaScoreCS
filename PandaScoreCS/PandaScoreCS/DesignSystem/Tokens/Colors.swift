
import SwiftUI

struct Colors {
    /// Background Color
    let background = Color(hex: "#161621")
    /// Background Color
    let background2 = Color(hex: "#272639")
    /// Light gray
    let neutral1 = Color(hex: "#C4C4C4")
    /// Light gray opacity 50%
    let neutral2 = Color(hex: "#C4C4C4").opacity(0.5)
    /// Light gray opacity 20%
    let neutral3 = Color(hex: "#C4C4C4").opacity(0.2)
    /// Dark gray
    let neutral4 = Color(hex: "#6C6B7E")
    /// White
    let primaryText = Color(hex: "#FFFFFF")
    /// Red
    let alert = Color(hex: "#F42A35")

}

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
