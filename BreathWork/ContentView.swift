import SwiftUI

struct ContentView: View {
    @State private var showWelcome = true
    @State private var showDurationSelection = false
    @State private var showCountdown = false
    @State private var showBreathingSession = false
    @State private var selectedDuration: Double = 60 // Default to 1 minute
    @State private var countdown: Int = 3 // Countdown from 3 seconds

    var body: some View {
        ZStack {
            if showWelcome {
                WelcomeView(showWelcome: $showWelcome)
                    .onDisappear {
                        print("WelcomeView Disappeared")
                        showDurationSelection = true
                    }
            } else if showDurationSelection {
                DurationSelectionView(showDurationSelection: $showDurationSelection, selectedDuration: $selectedDuration, showCountdown: $showCountdown)
                    .onAppear {
                        print("DurationSelectionView Appeared")
                    }
            } else if showCountdown {
                CountdownView(showCountdown: $showCountdown, countdown: $countdown, showBreathingSession: $showBreathingSession)
                    .onAppear {
                        print("CountdownView Appeared")
                    }
            } else if showBreathingSession {
                BreathingSessionView(remainingTime: selectedDuration, showDurationSelection: $showDurationSelection)
                    .onAppear {
                        print("BreathingSessionView Appeared")
                    }
            }
        }
        .animation(.easeInOut, value: showWelcome)
        .animation(.easeInOut, value: showDurationSelection)
        .animation(.easeInOut, value: showCountdown)
        .animation(.easeInOut, value: showBreathingSession)
        .transition(.opacity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
