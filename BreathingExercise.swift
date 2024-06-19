import SwiftUI

struct BreathingExercise: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let duration: Double
    let description: String
    let detailedDescription: String

    static func ==(lhs: BreathingExercise, rhs: BreathingExercise) -> Bool {
        return lhs.id == rhs.id
    }
}
