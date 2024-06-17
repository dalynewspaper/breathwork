import SwiftUI

struct ContentView: View {
    @State private var showWelcome = true
    @State private var showDurationSelection = false
    @State private var showCountdown = false
    @State private var showBreathingSession = false
    @State private var selectedDuration: Double = 60 // Default to 1 minute
    @State private var countdown = 3 // Countdown from 3 seconds

    var body: some View {
        ZStack {
            if showWelcome {
                WelcomeView(showWelcome: $showWelcome)
                    .onDisappear {
                        showDurationSelection = true
                    }
            } else if showDurationSelection {
                DurationSelectionView(showDurationSelection: $showDurationSelection, selectedDuration: $selectedDuration, showCountdown: $showCountdown)
            } else if showCountdown {
                CountdownView(showCountdown: $showCountdown, countdown: $countdown, showBreathingSession: $showBreathingSession, showDurationSelection: $showDurationSelection)
            } else if showBreathingSession {
                BreathingSessionView(remainingTime: selectedDuration)
            }
        }
        .animation(.easeInOut, value: showWelcome)
        .transition(.opacity)
    }
}
