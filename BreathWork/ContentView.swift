import SwiftUI

struct ContentView: View {
    @State private var showHomeView = true
    @State private var selectedExercise: BreathingExercise?
    @State private var selectedDuration: Double = 60

    var body: some View {
        ZStack {
            if showHomeView {
                HomeView(showHomeView: $showHomeView, selectedExercise: $selectedExercise, selectedDuration: $selectedDuration)
            } else if let exercise = selectedExercise {
                BreathingSessionView(exercise: exercise, showHomeView: $showHomeView, selectedDuration: selectedDuration)
            }
        }
        .animation(.easeInOut)
        .transition(.opacity)
    }
}
