import SwiftUI

struct ContentView: View {
    @State private var showHomeView = true
    @State private var selectedExercise: BreathingExercise?

    var body: some View {
        ZStack {
            if showHomeView {
                HomeView(showHomeView: $showHomeView, selectedExercise: $selectedExercise)
            } else if let exercise = selectedExercise {
                BreathingSessionView(exercise: exercise, showHomeView: $showHomeView)
            }
        }
        .animation(.easeInOut)
        .transition(.opacity)
    }
}
