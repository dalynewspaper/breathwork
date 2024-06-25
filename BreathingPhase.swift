import SwiftUI

struct BreathingPhase {
    let name: String
    let duration: Double
    let color: Color
}

// Define the breathing phases for each exercise
let diaphragmaticPhases = [
    BreathingPhase(name: "Inhale", duration: 4, color: .green),
    BreathingPhase(name: "Exhale", duration: 6, color: .blue)
]

let fourSevenEightPhases = [
    BreathingPhase(name: "Inhale", duration: 4, color: .green),
    BreathingPhase(name: "Hold", duration: 7, color: .yellow),
    BreathingPhase(name: "Exhale", duration: 8, color: .blue)
]

let boxBreathingPhases = [
    BreathingPhase(name: "Hold", duration: 4, color: .purple),
    BreathingPhase(name: "Inhale", duration: 4, color: .green),
    BreathingPhase(name: "Hold", duration: 4, color: .yellow),
    BreathingPhase(name: "Exhale", duration: 4, color: .blue)
]

let alternateNostrilPhases = [
    BreathingPhase(name: "Inhale Left", duration: 4, color: .green),
    BreathingPhase(name: "Exhale Right", duration: 4, color: .blue),
    BreathingPhase(name: "Inhale Right", duration: 4, color: .green),
    BreathingPhase(name: "Exhale Left", duration: 4, color: .blue)
]

let buteykoPhases = [
    BreathingPhase(name: "Small Inhale", duration: 2, color: .green),
    BreathingPhase(name: "Small Exhale", duration: 2, color: .blue),
    BreathingPhase(name: "Hold", duration: 5, color: .yellow)
]

let pursedLipPhases = [
    BreathingPhase(name: "Inhale", duration: 2, color: .green),
    BreathingPhase(name: "Exhale", duration: 4, color: .blue)
]
