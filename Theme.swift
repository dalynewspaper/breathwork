import SwiftUI

enum Theme: String, CaseIterable, Identifiable {
    case defaultTheme
    case calmingTheme
    case energizingTheme

    var id: String { self.rawValue }

    var gradient: Gradient {
        switch self {
        case .defaultTheme:
            return Gradient(colors: [Color.blue, Color.purple])
        case .calmingTheme:
            return Gradient(colors: [Color.green, Color.blue])
        case .energizingTheme:
            return Gradient(colors: [Color.red, Color.orange])
        }
    }
}
